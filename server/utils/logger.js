import fs from 'fs';
import path from 'path';
import { fileURLToPath } from 'url';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const logsDir = path.join(__dirname, '../logs');

// Ensure directory exists
if (!fs.existsSync(logsDir)) {
  fs.mkdirSync(logsDir, { recursive: true });
}

export const logErrorToFile = (errorType, errorDetails) => {
  const timestamp = new Date().toISOString();
  const logFilePath = path.join(logsDir, 'error.log');

  const logMessage = `[${timestamp}] [${errorType}]\n${
    typeof errorDetails === 'object' ? JSON.stringify(errorDetails, null, 2) : errorDetails
  }\n--------------------------------------------------\n`;

  // Always print to terminal console immediately
  console.error(`🚨 [LOGGER TRIGGERED] ${errorType}:`, errorDetails);

  try {
    fs.appendFileSync(logFilePath, logMessage, 'utf8');
    console.log(`📄 Log written successfully to: ${logFilePath}`);
  } catch (err) {
    console.error('❌ Failed writing to log file:', err.message);
  }
};
