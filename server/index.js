import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import authenticateToken from './middleware/auth.js';
import transactionRoutes from './routes/transactions.js';
import emiRoutes from './routes/emis.js';

dotenv.config();

const app = express();
const PORT = process.env.PORT || 5001;

app.use(cors());
app.use(express.json());

// Request logger
app.use((req, res, next) => {
  console.log(`[${new Date().toLocaleTimeString()}] ${req.method} ${req.url}`);
  next();
});

// Root route for quick health checks
app.get('/', (req, res) => {
  res.send('Expense Dashboard API is active!');
});

// API Routes
app.use('/api/transactions', authenticateToken, transactionRoutes);
app.use('/api/emis', authenticateToken, emiRoutes);

// Catch-all for unhandled routes
app.use((req, res) => {
  res.status(404).json({ error: 'Endpoint not found' });
});

// Start listening
app.listen(PORT, () => {
  console.log(`🚀 Express Backend running on http://localhost:${PORT}`);
});

// Prevent immediate crash on unhandled promise rejections
process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
});