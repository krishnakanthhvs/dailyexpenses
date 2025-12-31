<?php
require_once 'inc/auth.php';
require_once 'inc/db.php';

$user_id = $_SESSION['user_id'];

$expense_date     = $_POST['expense_date'];
$expense_for  = trim($_POST['expense_for']);
$expense_type = $expense_for; // fallback
$amount           = $_POST['amount'];
$necessity_rating = $_POST['necessity_rating'];
$reason           = trim($_POST['reason']);
$payment_type     = $_POST['payment_type'];
$online_app       = ($payment_type === 'online') ? ($_POST['online_app'] ?? null) : null;

$sql = "INSERT INTO expenses
        (user_id, expense_date, expense_for, amount, necessity_rating, reason, payment_type, online_app)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

$stmt = $conn->prepare($sql);
$stmt->bind_param(
    "issdisss",
    $user_id,
    $expense_date,
    $expense_for,
    $amount,
    $necessity_rating,
    $reason,
    $payment_type,
    $online_app
);

$stmt->execute();

$_SESSION['success'] = "Expense added successfully";
header("Location: expenses.php");
exit;