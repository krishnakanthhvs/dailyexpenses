import express from 'express';
import pool from '../db.js';
import { logErrorToFile } from '../utils/logger.js';

const router = express.Router();

// 🟢 GET: Fetch All Transactions for Authenticated User
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
        spent_by AS "spentBy",
        to_char(transaction_date, 'YYYY-MM-DD') AS "date",
        created_at AS "createdAt"
      FROM transactions 
      WHERE user_id = $1 
      ORDER BY transaction_date DESC, created_at DESC;
    `;

    const result = await pool.query(query, [userId]);
    res.json(result.rows);
  } catch (err) {
    logErrorToFile('DB_FETCH_ERROR', { message: err.message, stack: err.stack });
    res.status(500).json({ error: `Database Fetch Error: ${err.message}` });
  }
});

// 🟢 POST: Save New Transaction (Authenticated User / Dashboard)
router.post('/', async (req, res) => {
  try {
    const userId = req.user ? req.user.id : 1;
    const { note, amount, category, type, paymentMethod, bankName, spentBy, date } = req.body;

    const cleanDate = (date && date.trim() !== '') ? date : new Date().toISOString().split('T')[0];

    const query = `
      INSERT INTO transactions 
        (user_id, note, amount, category, type, payment_method, bank_name, spent_by, transaction_date)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
      RETURNING 
        id, 
        user_id AS "userId", 
        note, 
        amount, 
        category, 
        type, 
        payment_method AS "paymentMethod", 
        bank_name AS "bankName", 
        spent_by AS "spentBy",
        to_char(transaction_date, 'YYYY-MM-DD') AS "date",
        created_at AS "createdAt";
    `;

    const values = [
      userId,
      note || '',
      parseFloat(amount) || 0,
      category || 'Food',
      type || 'Debit',
      paymentMethod || 'UPI',
      bankName || 'HDFC Bank',
      spentBy || 'Self',
      cleanDate,
    ];

    const result = await pool.query(query, values);
    res.status(201).json(result.rows[0]);
  } catch (err) {
    logErrorToFile('DB_INSERT_ERROR', { message: err.message, stack: err.stack, bodySent: req.body });
    res.status(500).json({ error: `Transaction save failed: ${err.message}` });
  }
});

// 🔴 DELETE: Remove Transaction by ID
router.delete('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user ? req.user.id : 1;

    const query = `
      DELETE FROM transactions 
      WHERE id = $1 AND user_id = $2 
      RETURNING id;
    `;

    const result = await pool.query(query, [id, userId]);

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Transaction not found or unauthorized to delete.' });
    }

    res.json({ success: true, message: 'Transaction deleted successfully', id: Number(id) });
  } catch (err) {
    logErrorToFile('DB_DELETE_ERROR', { message: err.message, id: req.params.id });
    res.status(500).json({ error: err.message });
  }
});

// 🔓 PUBLIC ROUTE: Add Transaction without login (Using User ID)
router.post('/public-add', async (req, res) => {
  try {
    const { userId, note, amount, category, type, paymentMethod, bankName, spentBy, date } = req.body;

    if (!userId || !amount || !note) {
      return res.status(400).json({ error: 'User ID, Note, and Amount are required.' });
    }

    const cleanDate = (date && date.trim() !== '') ? date : new Date().toISOString().split('T')[0];

    const query = `
      INSERT INTO transactions 
        (user_id, note, amount, category, type, payment_method, bank_name, spent_by, transaction_date)
      VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
      RETURNING 
        id, 
        user_id AS "userId", 
        note, 
        amount, 
        category, 
        type, 
        payment_method AS "paymentMethod", 
        bank_name AS "bankName", 
        spent_by AS "spentBy", 
        to_char(transaction_date, 'YYYY-MM-DD') AS "date";
    `;

    const values = [
      userId,
      note,
      parseFloat(amount),
      category || 'Food',
      type || 'Debit',
      paymentMethod || 'UPI',
      bankName || 'HDFC Bank',
      spentBy || 'Self',
      cleanDate
    ];

    const result = await pool.query(query, values);
    res.status(201).json({ success: true, transaction: result.rows[0] });
  } catch (err) {
    logErrorToFile('PUBLIC_ADD_EXPENSE_ERROR', { message: err.message, bodySent: req.body });
    res.status(500).json({ error: `Failed to record expense: ${err.message}` });
  }
});

export default router;