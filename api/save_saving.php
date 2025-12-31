<?php
require_once '../inc/auth.php';
require_once '../inc/db.php';

$userId = $_SESSION['user_id'];
$month  = date('Y-m');

$income = $_POST['income'];
$saved  = $_POST['saved_amount'] ?? 0;
$note   = $_POST['note'] ?? '';

$stmt = $conn->prepare("
    INSERT INTO savings (user_id, month_year, income, saved_amount, note)
    VALUES (?, ?, ?, ?, ?)
");
$stmt->bind_param("isdds", $userId, $month, $income, $saved, $note);
$stmt->execute();

$_SESSION['success'] = "Savings added successfully";
header("Location: ../savings.php");
exit;