import pg from 'pg';
import dotenv from 'dotenv';

dotenv.config();

const { Pool } = pg;

const pool = new Pool({
  user: process.env.DB_USER || 'postgres',
  host: process.env.DB_HOST || 'localhost',
  database: process.env.DB_NAME || 'expense_tracker_db',
  password: process.env.DB_PASSWORD || 'Admin123', // Put your local DB password here
  port: process.env.DB_PORT || 5432,
});

pool.on('connect', () => {
  console.log('🐘 Connected to PostgreSQL Database');
});

// IMPORTANT: Do NOT call process.exit() in the error listener during dev!
pool.on('error', (err) => {
  console.error('Unexpected error on idle PG client:', err.message);
});

export default pool;
