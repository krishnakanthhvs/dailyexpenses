import express from 'express';
import pool from '../db.js';
import { logErrorToFile } from '../utils/logger.js';

const router = express.Router();

// 🟢 GET: Fetch family members for authenticated user (Dashboard)
router.get('/', async (req, res) => {
  try {
    const userId = req.user ? req.user.id : 1;
    const query = `
      SELECT id, name, relationship, created_at AS "createdAt"
      FROM family_members
      WHERE user_id = $1
      ORDER BY id ASC;
    `;
    const result = await pool.query(query, [userId]);
    res.json(result.rows);
  } catch (err) {
    logErrorToFile('FAMILY_FETCH_ERROR', { message: err.message });
    res.status(500).json({ error: `Failed to fetch family members: ${err.message}` });
  }
});

// 🟢 POST: Add a new family member (Dashboard)
router.post('/', async (req, res) => {
  try {
    const userId = req.user ? req.user.id : 1;
    const { name, relationship } = req.body;

    if (!name || !relationship) {
      return res.status(400).json({ error: 'Name and relationship are required.' });
    }

    const query = `
      INSERT INTO family_members (user_id, name, relationship)
      VALUES ($1, $2, $3)
      RETURNING id, name, relationship, created_at AS "createdAt";
    `;
    const result = await pool.query(query, [userId, name, relationship]);
    res.status(201).json(result.rows[0]);
  } catch (err) {
    logErrorToFile('FAMILY_ADD_ERROR', { message: err.message });
    res.status(500).json({ error: `Failed to add family member: ${err.message}` });
  }
});

// 🔴 DELETE: Remove a family member (Dashboard)
router.delete('/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const userId = req.user ? req.user.id : 1;

    const query = `DELETE FROM family_members WHERE id = $1 AND user_id = $2 RETURNING id;`;
    const result = await pool.query(query, [id, userId]);

    if (result.rowCount === 0) {
      return res.status(404).json({ error: 'Family member not found.' });
    }
    res.json({ success: true, id: Number(id) });
  } catch (err) {
    logErrorToFile('FAMILY_DELETE_ERROR', { message: err.message });
    res.status(500).json({ error: err.message });
  }
});

// 🔓 PUBLIC ROUTE: Lookup User & Family Members by Email (No Auth Required)
router.get('/public-lookup', async (req, res) => {
  try {
    const { email } = req.query;
    if (!email) {
      return res.status(400).json({ error: 'Email query parameter is required.' });
    }

    // Lookup user ID by email
    const userResult = await pool.query(`SELECT id, email FROM users WHERE LOWER(email) = LOWER($1);`, [email.trim()]);

    if (userResult.rowCount === 0) {
      return res.status(404).json({ error: 'No user account found with this Email ID.' });
    }

    const userId = userResult.rows[0].id;

    // Fetch family members associated with this user
    const membersResult = await pool.query(
      `SELECT name, relationship FROM family_members WHERE user_id = $1 ORDER BY id ASC;`,
      [userId]
    );

    res.json({
      userId,
      email: userResult.rows[0].email,
      familyMembers: membersResult.rows
    });
  } catch (err) {
    logErrorToFile('PUBLIC_LOOKUP_ERROR', { message: err.message });
    res.status(500).json({ error: `Lookup failed: ${err.message}` });
  }
});

export default router;