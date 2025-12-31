<?php
session_start();
require_once '../inc/auth.php';
require_once '../inc/db.php';

$userId = $_SESSION['user_id'];

/* Prevent more than 10 goals */
$check = $conn->prepare("SELECT COUNT(*) FROM goals WHERE user_id = ?");
$check->bind_param("i", $userId);
$check->execute();
$check->bind_result($count);
$check->fetch();
$check->close();

if ($count >= 10) {
    $_SESSION['error'] = "Maximum 10 goals allowed";
    header("Location: ../goals.php");
    exit;
}

/* Collect form data */
$goalName   = $_POST['goal_name'];
$goalType   = $_POST['goal_type'];
$goalFor    = $_POST['goal_for'];
$goalDesc   = $_POST['goal_desc'];
$icon       = $_POST['icon'];
$amount     = $_POST['amount'];
$occasion   = $_POST['occasion'];
$targetDate = $_POST['target_date'];

/* Insert goal */
$stmt = $conn->prepare("
    INSERT INTO goals
    (user_id, goal_name, goal_type, goal_for, goal_desc, icon, amount, occasion, target_date)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
");

$stmt->bind_param(
    "isssssiss",
    $userId,
    $goalName,
    $goalType,
    $goalFor,
    $goalDesc,
    $icon,
    $amount,
    $occasion,
    $targetDate
);

$stmt->execute();
$stmt->close();

$_SESSION['success'] = "Goal added successfully 🎯";
header("Location: ../goals.php");
exit;