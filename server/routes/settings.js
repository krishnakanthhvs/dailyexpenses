import express from 'express';
import nodemailer from 'nodemailer';
import db from '../db.js';

const router = express.Router();

// 1. Get User Settings & Preferences (PostgreSQL)
router.get('/', async (req, res) => {
  try {
    const userId = req.user?.id || req.userId || 1;

    // Fetch user profile
    const userRes = await db.query(
      'SELECT full_name, email, phone, username, username_change_count FROM users WHERE id = $1',
      [userId]
    );

    // Fetch user preferences
    const settingsRes = await db.query(
      'SELECT email_alerts_enabled, email_alert_frequency, emi_reminder_time, whatsapp_alerts_enabled FROM user_settings WHERE user_id = $1',
      [userId]
    );

    const user = userRes.rows[0] || {};
    const settings = settingsRes.rows[0] || {};

    res.json({
      profile: {
        fullName: user.full_name || '',
        email: user.email || '',
        phone: user.phone || '',
        username: user.username || '',
        usernameChangeCount: user.username_change_count || 0
      },
      preferences: {
        emailAlertsEnabled: settings.email_alerts_enabled !== undefined ? Boolean(settings.email_alerts_enabled) : true,
        emailAlertFrequency: settings.email_alert_frequency || 'Monthly',
        emiReminderTime: settings.emi_reminder_time || '2 Days',
        whatsappAlertsEnabled: settings.whatsapp_alerts_enabled !== undefined ? Boolean(settings.whatsapp_alerts_enabled) : false
      }
    });

  } catch (err) {
    console.error('Error fetching settings from DB:', err.message);
    res.status(500).json({ error: 'Failed to fetch settings' });
  }
});

// 2. Update Profile
router.put('/profile', async (req, res) => {
  try {
    const userId = req.user?.id || req.userId || 1;
    const { fullName, email, phone } = req.body;

    await db.query(
      'UPDATE users SET full_name = $1, email = $2, phone = $3 WHERE id = $4',
      [fullName, email, phone, userId]
    );

    res.json({ message: 'Profile updated successfully' });
  } catch (err) {
    console.error('Error updating profile in DB:', err.message);
    res.status(500).json({ error: 'Failed to update profile' });
  }
});

// 3. Update Username (Allowed ONCE per user)
router.put('/username', async (req, res) => {
  try {
    const userId = req.user?.id || req.userId || 1;
    const { username } = req.body;

    if (!username || username.trim().length < 3) {
      return res.status(400).json({ error: 'Username must be at least 3 characters long.' });
    }

    // Check current username change count
    const userRes = await db.query(
      'SELECT username_change_count FROM users WHERE id = $1',
      [userId]
    );

    const changeCount = userRes.rows[0]?.username_change_count || 0;

    if (changeCount >= 1) {
      return res.status(403).json({ error: 'Username can only be changed once.' });
    }

    // Update username and increment change count
    await db.query(
      'UPDATE users SET username = $1, username_change_count = username_change_count + 1 WHERE id = $2',
      [username.trim().toLowerCase(), userId]
    );

    res.json({ message: 'Username updated successfully!' });
  } catch (err) {
    console.error('Error updating username in DB:', err.message);

    // Code 23505 = Unique constraint violation in PostgreSQL
    if (err.code === '23505') {
      return res.status(400).json({ error: 'Username is already taken by another user.' });
    }

    res.status(500).json({ error: 'Failed to update username due to a server error.' });
  }
});

// 4. Change Password
router.put('/change-password', async (req, res) => {
  try {
    const userId = req.user?.id || req.userId || 1;
    const { newPassword } = req.body;

    await db.query('UPDATE users SET password = $1 WHERE id = $2', [newPassword, userId]);

    res.json({ message: 'Password updated successfully' });
  } catch (err) {
    console.error('Error updating password in DB:', err.message);
    res.status(500).json({ error: 'Failed to update password' });
  }
});

// 5. Update Preferences (PostgreSQL UPSERT)
router.put('/preferences', async (req, res) => {
  try {
    const userId = req.user?.id || req.userId || 1;
    const preferences = req.body;

    const upsertSql = `
      INSERT INTO user_settings (user_id, email_alerts_enabled, email_alert_frequency, emi_reminder_time, whatsapp_alerts_enabled)
      VALUES ($1, $2, $3, $4, $5)
      ON CONFLICT (user_id) 
      DO UPDATE SET
        email_alerts_enabled = EXCLUDED.email_alerts_enabled,
        email_alert_frequency = EXCLUDED.email_alert_frequency,
        emi_reminder_time = EXCLUDED.emi_reminder_time,
        whatsapp_alerts_enabled = EXCLUDED.whatsapp_alerts_enabled
    `;

    await db.query(upsertSql, [
      userId,
      preferences.emailAlertsEnabled,
      preferences.emailAlertFrequency,
      preferences.emiReminderTime,
      preferences.whatsappAlertsEnabled
    ]);

    res.json({ message: 'Preferences updated successfully' });
  } catch (err) {
    console.error('Error updating preferences in DB:', err.message);
    res.status(500).json({ error: 'Failed to update preferences' });
  }
});

// 6. Send Test Email
router.post('/test-email', async (req, res) => {
  const { email } = req.body;

  if (!email) {
    return res.status(400).json({ error: 'Email address is required' });
  }

  const gmailUser = process.env.GMAIL_USER;
  const gmailPass = process.env.GMAIL_APP_PASS;

  if (!gmailUser || !gmailPass) {
    return res.status(500).json({ 
      error: 'Server email credentials (GMAIL_USER / GMAIL_APP_PASS) are not loaded from .env file.' 
    });
  }

  try {
    const transporter = nodemailer.createTransport({
      service: 'gmail',
      auth: {
        user: gmailUser,
        pass: gmailPass,
      },
    });

    await transporter.sendMail({
      from: `"ExpenseFlow" <${gmailUser}>`,
      to: email,
      subject: 'ExpenseFlow - Test Email Verification',
      html: `
        <div style="font-family: Arial, sans-serif; padding: 20px; background-color: #f8fafc; border-radius: 8px; border: 1px solid #e2e8f0; max-width: 500px; margin: auto;">
          <h2 style="color: #4f46e5; margin-top: 0;">ExpenseFlow Verification Test</h2>
          <p>Hello,</p>
          <p>This is a real-time test email sent from ExpenseFlow to <strong>${email}</strong>!</p>
          <p>Your email notification setup is working properly.</p>
        </div>
      `,
    });

    res.json({ message: `Test email sent to ${email}!` });
  } catch (err) {
    console.error('SMTP Error:', err.message);
    res.status(500).json({ error: 'Failed to send test email: ' + err.message });
  }
});

export default router;