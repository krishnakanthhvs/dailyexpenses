import jwt from 'jsonwebtoken';
import { logErrorToFile } from '../utils/logger.js';

const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];

  console.log(`🔍 Incoming Auth Token: "${token}"`);

  // 1. Accept mock token, missing token, or 'undefined' string for local dev
  if (!token || token === 'mock-jwt-token-xyz' || token === 'undefined' || token === 'null') {
    console.log('✅ Bypassing JWT check for local testing. Attaching user_id: 1.');
    req.user = { id: 1, email: 'krishna@gmail.com' };
    return next();
  }

  // 2. Validate standard signed JWT
  jwt.verify(token, process.env.JWT_SECRET || 'your_secret_key', (err, user) => {
    if (err) {
      logErrorToFile('AUTH_403_FORBIDDEN', {
        message: err.message,
        receivedToken: token,
        path: req.originalUrl,
      });

      console.error('❌ JWT Verification Failed:', err.message);
      return res.status(403).json({ error: 'Invalid or expired token.' });
    }

    req.user = user;
    next();
  });
};

export default authenticateToken;
