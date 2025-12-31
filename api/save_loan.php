<?php
require_once '../inc/auth.php';
require_once '../inc/db.php';

$emi = $_POST['emi'] ?? 0;

$stmt = $conn->prepare("
    INSERT INTO loans
    (user_id, loan_name, lender_type, lender_name,
     principal, interest_rate, tenure_months,
     emi, start_date)
    VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
");

$stmt->bind_param(
    "isssddids",
    $_SESSION['user_id'],
    $_POST['loan_name'],
    $_POST['lender_type'],
    $_POST['lender_name'],
    $_POST['principal'],
    $_POST['interest_rate'],
    $_POST['tenure_months'],
    $emi,
    $_POST['start_date']
);

$stmt->execute();
header("Location: ../loans.php");