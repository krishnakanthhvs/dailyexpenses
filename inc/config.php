<?php

date_default_timezone_set('Asia/Kolkata');

// inc/config.php

/* =========================================================
   APP SETTINGS
========================================================= */

define('APP_NAME', 'My Expenses');

/*
 | Detect environment based on domain
 | Production: https://dailyexpenses.mydailydiary.space
 | Local: everything else
*/
$host = $_SERVER['HTTP_HOST'] ?? 'localhost';

if ($host === 'dailyexpenses.mydailydiary.space') {

    /* ================== PRODUCTION ================== */
    define('APP_URL', 'https://dailyexpenses.mydailydiary.space/');

    define('DB_HOST', 'localhost');
    define('DB_NAME', 'u788563593_dailyexpenses');   // prod DB name
    define('DB_USER', 'u788563593_dailyexpenses');        // 🔒 replace
    define('DB_PASS', '>9fw5ay2lJ5');    // 🔒 replace

    // Hide errors in production
    error_reporting(0);
    ini_set('display_errors', 0);

} else {

    /* ================== LOCAL ================== */
    define('APP_URL', 'http://localhost/my-expenses');

    define('DB_HOST', 'localhost');
    define('DB_NAME', 'expense_dashboard');
    define('DB_USER', 'root');
    define('DB_PASS', 'root');

    // Show errors in local
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
}

/* =========================================================
   SESSION
========================================================= */
if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

// Global PHP error handler
set_error_handler(function ($severity, $message, $file, $line) {
    appLog(
        $message,
        'error',
        [
            'file' => $file,
            'line' => $line,
            'severity' => $severity
        ]
    );
});

// Global exception handler
set_exception_handler(function ($exception) {
    appLog(
        $exception->getMessage(),
        'exception',
        [
            'file' => $exception->getFile(),
            'line' => $exception->getLine(),
            'trace' => $exception->getTraceAsString()
        ]
    );
});