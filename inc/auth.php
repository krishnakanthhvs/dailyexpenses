<?php
// inc/auth.php

require_once __DIR__ . '/config.php';
require_once __DIR__ . '/db.php';
require_once __DIR__ . '/functions.php';

/* -------------------------------
   AUTH CHECK
-------------------------------- */
if (!isset($_SESSION['user_id'])) {
    header('Location: login.php');
    exit;
}

$userId = $_SESSION['user_id'];
$currentMonth = date('Y-m');

/* -------------------------------
   MONTHLY LIMIT CHECK (GLOBAL)
-------------------------------- */
$stmt = $conn->prepare("
    SELECT id
    FROM monthly_limits
    WHERE user_id = ? AND month_year = ?
    LIMIT 1
");
$stmt->bind_param("is", $userId, $currentMonth);
$stmt->execute();
$stmt->store_result();

$hasMonthlyLimit = $stmt->num_rows > 0;
$stmt->close();

/*
 | Store globally for UI usage
 | Used by dashboard, expenses, goals, savings, loans
*/
define('HAS_MONTHLY_LIMIT', $hasMonthlyLimit);

/* -------------------------------
   BLOCK ACCESS IF NOT SET
-------------------------------- */
$currentPage = basename($_SERVER['PHP_SELF']);

$allowedPages = [
    'logout.php',
    'save_monthly_limit.php'
];

if (!$hasMonthlyLimit && !in_array($currentPage, $allowedPages)) {
    // Allow page to load but force modal
    $_SESSION['FORCE_MONTHLY_LIMIT'] = true;
}