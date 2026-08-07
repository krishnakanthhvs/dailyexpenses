import express from 'express';
import pool from '../db.js';

const router = express.Router();

// GET: Fetch All Transactions
router.get('/', async (req, res) => {
  try {
    const userId = req.user ? req.user.id : 1;

    const query = `
      SELECT 
        id, 
        user_id AS "userId", 
        note, 
        amount, 
        category, 
        type, 
        payment_method AS "paymentMethod", 
        bank_name AS "bankName", 
        to_char(transaction_date, 'YYYY-MM-DD') AS "date",
        created_at AS "createdAt"
      FROM transactions 
      WHERE user_id = $1 
      ORDER BY transaction_date DESC, created_at DESC;
    `;

    const result = await pool.query(query, [userId]);
    res.json(result.rows);
  } catch (err) {
    console.error('Error fetching transactions:', err.message);
    res.status(500).json({ error: `Database Fetch Error: ${err.message}` });
  }
});

// POST: Save New Transaction
router.post('/', async (req, res) => {
  try {
    const userId = req.user ? req.user.id : 1;
    const { note, amount, category, type, paymentMethod, bankName, date } = req.body;

    const cleanDate = (date && date.trim() !== '') ? date : new Date().toISOString().split('T')[0];

    const query = `
      INSERT INTO transactions 
        (user_id, note, amount, category, type, payment_method, bank_name, transaction_date)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8)
      RETURNING 
        id, 
        user_id AS "userId", 
        note, 
        amount, 
        category, 
        type, 
        payment_method AS "paymentMethod", 
        bank_name AS "bankName", 
        to_char(transaction_date, 'YYYY-MM-DD') AS "date",
        created_at AS "createdAt";
    `;

    const values = [
      userId,
      note || '',
      parseFloat(amount) || 0,
      category || 'Food & Dining',
      type || 'Debit',
      paymentMethod || 'UPI',
      bankName || 'HDFC Bank',
      cleanDate,
    ];

    const result = await pool.query(query, values);
    res.status(201).json(result.rows[0]);
  } catch (err) {
    console.error('Error inserting transaction:', err.message);
    res.status(500).json({ error: `Transaction save failed: ${err.message}` });
  }
});

// DELETE: Delete Transaction
router.delete('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user ? req.user.id : 1;

    const result = await pool.query(
      'DELETE FROM transactions WHERE id = $1 AND user_id = $2 RETURNING id',
      [id, userId]
    );

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Transaction not found' });
    }

    res.json({ success: true, id: Number(id) });
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

export default router;