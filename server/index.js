import express from 'express';
import cors from 'cors';
import dotenv from 'dotenv';
import authenticateToken from './middleware/auth.js';
import transactionRoutes from './routes/transactions.js';
import emiRoutes from './routes/emis.js';
import familyRoutes from './routes/family.js';
import settingsRoutes from './routes/settings.js';
import authRouter from './routes/auth.js';

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

// Root route for health check
app.get('/', (req, res) => {
  res.send('Expense Dashboard API is active!');
});

// 🔓 1. PUBLIC / UNGUARDED ROUTES (Mounted directly to router)
app.use('/api/family', familyRoutes); 
// Note: /api/family/public-lookup is inside familyRoutes and will be accessible without auth.

app.use('/api/transactions', transactionRoutes); 
// Note: /api/transactions/public-add is inside transactionRoutes and handles unauthenticated posts.

// 🔒 2. AUTHENTICATED ROUTES
app.use('/api/emis', authenticateToken, emiRoutes);

app.use('/api/settings', authenticateToken, settingsRoutes);

app.use('/api/auth', authRouter);

// 3. CATCH-ALL FOR UNHANDLED ENDPOINTS
app.use((req, res) => {
  res.status(404).json({ error: 'Endpoint not found' });
});

// Start listening
app.listen(PORT, () => {
  console.log(`🚀 Express Backend running on http://localhost:${PORT}`);
});

process.on('unhandledRejection', (reason, promise) => {
  console.error('Unhandled Rejection at:', promise, 'reason:', reason);
});