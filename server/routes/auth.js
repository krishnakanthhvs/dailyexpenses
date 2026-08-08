import express from 'express';
import bcrypt from 'bcryptjs';
import jwt from 'jsonwebtoken';
import db from '../db.js';

const router = express.Router();

/**
 * POST /api/auth/login
 * Supports login via Username, Email, or Phone Number.
 * Handles plain-text fallback, bcrypt hashing, and CHAR padding.
 */
router.post('/login', async (req, res) => {
  const { identifier, password } = req.body;

  if (!identifier || !password) {
    return res.status(400).json({ error: 'Please enter your username, email, or phone and password.' });
  }

  const cleanIdentifier = identifier.trim().toLowerCase();
  const rawIdentifier = identifier.trim();

  try {
    // 1. Fetch user by username, email, or phone (ignoring spaces in phone)
    const userRes = await db.query(
      `SELECT * FROM users 
       WHERE LOWER(username) = $1 
          OR LOWER(email) = $1 
          OR REPLACE(phone, ' ', '') = REPLACE($2, ' ', '')`,
      [cleanIdentifier, rawIdentifier]
    );

    const user = userRes.rows[0];

    if (!user) {
      return res.status(401).json({ error: 'Invalid credentials. User not found.' });
    }

    // 2. Trim whitespace from stored password (fixes PostgreSQL CHAR column padding)
    const rawStored = user.password_hash || user.password || '';
    const storedPassword = rawStored.trim();

    let isPasswordValid = false;

    // Safely verify password (supports bcrypt hashes OR plain text testing)
    if (storedPassword.startsWith('$2a$') || storedPassword.startsWith('$2b$')) {
      isPasswordValid = await bcrypt.compare(password, storedPassword);
    } else {
      // Plain text equality check (trimmed)
      isPasswordValid = password.trim() === storedPassword;
    }

    if (!isPasswordValid) {
      return res.status(401).json({ error: 'Invalid credentials. Incorrect password.' });
    }

    // 3. Generate JWT Token
    const token = jwt.sign(
      { id: user.id, username: user.username, email: user.email },
      process.env.JWT_SECRET || 'your_fallback_secret',
      { expiresIn: '7d' }
    );

    // 4. Return success response with token & user info
    res.json({
      message: 'Login successful',
      token,
      user: {
        id: user.id,
        fullName: user.full_name,
        username: user.username,
        email: user.email,
        phone: user.phone
      }
    });

  } catch (err) {
    console.error('Login Error:', err.message);
    res.status(500).json({ error: 'Server error during login. Please try again.' });
  }
});

export default router;