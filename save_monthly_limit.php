<?php
require_once 'inc/auth.php';
require_once 'inc/db.php';

$month = date('Y-m');
$limit = $_POST['limit_amount'];

/* Prevent duplicate insert */
$stmt = $conn->prepare("
    INSERT IGNORE INTO monthly_limits (user_id, month_year, limit_amount)
    VALUES (?, ?, ?)
");
$stmt->bind_param("isd", $_SESSION['user_id'], $month, $limit);
$stmt->execute();

header("Location: dashboard.php");
exit;