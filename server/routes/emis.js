import express from 'express';
import pool from '../db.js';
import { logErrorToFile } from '../utils/logger.js';

const router = express.Router();

/**
 * Helper: Recalculate Monthly EMI using Standard Amortization Formula
 * EMI = [P x R x (1+R)^N] / [(1+R)^N - 1]
 */
const calculateEMI = (principal, annualRate, monthsLeft) => {
  if (principal <= 0 || monthsLeft <= 0) return 0;
  if (annualRate <= 0) return principal / monthsLeft;

  const monthlyRate = annualRate / 12 / 100;
  const emi =
    (principal * monthlyRate * Math.pow(1 + monthlyRate, monthsLeft)) /
    (Math.pow(1 + monthlyRate, monthsLeft) - 1);
  return Math.round(emi);
};

// -----------------------------------------------------------------------------
// 1. GET: Fetch all active, completed, and foreclosed EMIs for current user
// -----------------------------------------------------------------------------
router.get('/', async (req, res) => {
  try {
    const userId = req.user ? req.user.id : 1;

    const query = `
      SELECT 
        id, 
        name, 
        lender, 
        deduction_bank AS "deductionBank", 
        principal, 
        interest_rate AS "interestRate", 
        tenure_months AS "tenureMonths", 
        paid_months AS "paidMonths", 
        deduction_day AS "deductionDay", 
        to_char(start_date, 'YYYY-MM-DD') AS "startDate",
        COALESCE(status, 'ACTIVE') AS status,
        created_at AS "createdAt",
        user_id AS "userId"
      FROM emis 
      WHERE user_id = $1 
      ORDER BY created_at DESC;
    `;

    const result = await pool.query(query, [userId]);
    res.json(result.rows);
  } catch (err) {
    console.error('Error fetching EMIs:', err.message);
    logErrorToFile('EMI_FETCH_ERROR', { message: err.message, stack: err.stack });
    res.status(500).json({ error: `Failed to fetch EMIs: ${err.message}` });
  }
});

// -----------------------------------------------------------------------------
// 2. POST: Create a new EMI record
// -----------------------------------------------------------------------------
router.post('/', async (req, res) => {
  try {
    const userId = req.user ? req.user.id : 1;
    const { 
      name, 
      lender, 
      deductionBank, 
      principal, 
      interestRate, 
      tenureMonths, 
      paidMonths, 
      deductionDay, 
      startDate 
    } = req.body;

    const query = `
      INSERT INTO emis 
        (user_id, name, lender, deduction_bank, principal, interest_rate, tenure_months, paid_months, deduction_day, start_date, status)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9, $10, 'ACTIVE')
      RETURNING 
        id, 
        name, 
        lender, 
        deduction_bank AS "deductionBank", 
        principal, 
        interest_rate AS "interestRate", 
        tenure_months AS "tenureMonths", 
        paid_months AS "paidMonths", 
        deduction_day AS "deductionDay", 
        to_char(start_date, 'YYYY-MM-DD') AS "startDate",
        COALESCE(status, 'ACTIVE') AS status,
        created_at AS "createdAt",
        user_id AS "userId";
    `;

    const values = [
      userId,
      name,
      lender || 'Lender / Bank',
      deductionBank || 'Bank Account',
      parseFloat(principal) || 0,
      parseFloat(interestRate) || 0,
      parseInt(tenureMonths, 10) || 12,
      parseInt(paidMonths, 10) || 0,
      parseInt(deductionDay, 10) || 5,
      startDate || new Date().toISOString().split('T')[0]
    ];

    const result = await pool.query(query, values);
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error('Error creating EMI:', err.message);
    logErrorToFile('EMI_CREATE_ERROR', { message: err.message, body: req.body });
    res.status(500).json({ error: `Failed to create EMI: ${err.message}` });
  }
});

// -----------------------------------------------------------------------------
// 3. PATCH: Increment Paid Months by 1
// -----------------------------------------------------------------------------
router.patch('/:id/increment', async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user ? req.user.id : 1;

    const query = `
      UPDATE emis 
      SET 
        paid_months = LEAST(paid_months + 1, tenure_months),
        status = CASE 
          WHEN paid_months + 1 >= tenure_months THEN 'COMPLETED' 
          ELSE COALESCE(status, 'ACTIVE') 
        END
      WHERE id = $1 AND user_id = $2
      RETURNING 
        id, 
        name, 
        lender, 
        deduction_bank AS "deductionBank", 
        principal, 
        interest_rate AS "interestRate", 
        tenure_months AS "tenureMonths", 
        paid_months AS "paidMonths", 
        deduction_day AS "deductionDay", 
        to_char(start_date, 'YYYY-MM-DD') AS "startDate",
        COALESCE(status, 'ACTIVE') AS status,
        user_id AS "userId";
    `;

    const result = await pool.query(query, [id, userId]);
    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'EMI record not found or unauthorized.' });
    }

    res.json(result.rows[0]);
  } catch (err) {
    logErrorToFile('EMI_INCREMENT_ERROR', { message: err.message, id: req.params.id });
    res.status(500).json({ error: `Failed to update paid EMI: ${err.message}` });
  }
});

// -----------------------------------------------------------------------------
// 4. POST: Apply Part Payment to Principal
// -----------------------------------------------------------------------------
router.post('/:id/part-payment', async (req, res) => {
  const client = await pool.connect();
  try {
    const { id } = req.params;
    const { amount, date } = req.body;
    const userId = req.user ? req.user.id : 1;

    const partAmount = parseFloat(amount);
    if (!partAmount || partAmount <= 0) {
      return res.status(400).json({ error: 'Valid part payment amount is required' });
    }

    await client.query('BEGIN');

    // Lock row for transactional update
    const emiRes = await client.query(
      'SELECT * FROM emis WHERE id = $1 AND user_id = $2 FOR UPDATE',
      [id, userId]
    );

    if (emiRes.rowCount === 0) {
      await client.query('ROLLBACK');
      return res.status(404).json({ error: 'EMI record not found' });
    }

    const emi = emiRes.rows[0];
    const newPrincipal = Math.max(0, parseFloat(emi.principal) - partAmount);
    const newStatus = newPrincipal === 0 ? 'FORECLOSED' : (emi.status || 'ACTIVE');

    // Update EMI principal balance and status
    const updateEmiQuery = `
      UPDATE emis 
      SET principal = $1, status = $2
      WHERE id = $3 AND user_id = $4
      RETURNING 
        id, 
        name, 
        lender, 
        deduction_bank AS "deductionBank", 
        principal, 
        interest_rate AS "interestRate", 
        tenure_months AS "tenureMonths", 
        paid_months AS "paidMonths", 
        deduction_day AS "deductionDay", 
        to_char(start_date, 'YYYY-MM-DD') AS "startDate",
        status,
        user_id AS "userId";
    `;
    const updatedRes = await client.query(updateEmiQuery, [newPrincipal, newStatus, id, userId]);

    // Track payment history if table exists
    await client.query(
      `INSERT INTO emi_part_payments (emi_id, amount, payment_date) 
       VALUES ($1, $2, $3) 
       ON CONFLICT DO NOTHING`,
      [id, partAmount, date || new Date().toISOString().split('T')[0]]
    ).catch(() => console.log('Notice: emi_part_payments table not populated.'));

    await client.query('COMMIT');
    res.json({ message: 'Part payment applied successfully', emi: updatedRes.rows[0] });

  } catch (err) {
    await client.query('ROLLBACK');
    console.error('Part Payment Error:', err.message);
    logErrorToFile('EMI_PART_PAYMENT_ERROR', { message: err.message, id: req.params.id });
    res.status(500).json({ error: err.message });
  } finally {
    client.release();
  }
});

// -----------------------------------------------------------------------------
// 5. PATCH: Foreclose Loan Completely
// -----------------------------------------------------------------------------
router.patch('/:id/foreclose', async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user ? req.user.id : 1;

    const query = `
      UPDATE emis 
      SET status = 'FORECLOSED', paid_months = tenure_months, principal = 0
      WHERE id = $1 AND user_id = $2
      RETURNING 
        id, 
        name, 
        lender, 
        deduction_bank AS "deductionBank", 
        principal, 
        interest_rate AS "interestRate", 
        tenure_months AS "tenureMonths", 
        paid_months AS "paidMonths", 
        deduction_day AS "deductionDay", 
        to_char(start_date, 'YYYY-MM-DD') AS "startDate",
        status,
        user_id AS "userId";
    `;

    const result = await pool.query(query, [id, userId]);
    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'EMI record not found' });
    }

    res.json({ message: 'Loan foreclosed successfully', emi: result.rows[0] });
  } catch (err) {
    logErrorToFile('EMI_FORECLOSE_ERROR', { message: err.message, id: req.params.id });
    res.status(500).json({ error: err.message });
  }
});

// -----------------------------------------------------------------------------
// 6. DELETE: Remove EMI record
// -----------------------------------------------------------------------------
router.delete('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user ? req.user.id : 1;

    const query = `
      DELETE FROM emis 
      WHERE id = $1 AND user_id = $2 
      RETURNING id;
    `;

    const result = await pool.query(query, [id, userId]);

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'EMI record not found or unauthorized.' });
    }

    res.json({ success: true, id: Number(id) });
  } catch (err) {
    logErrorToFile('EMI_DELETE_ERROR', { message: err.message, id: req.params.id });
    res.status(500).json({ error: err.message });
  }
});

export default router;