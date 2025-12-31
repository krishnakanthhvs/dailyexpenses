<?php
require_once '../inc/auth.php';
require_once '../inc/db.php';

$stmt = $conn->prepare("
    UPDATE users
    SET name=?, email=?, phone=?, gender=?
    WHERE id=?
");
$stmt->bind_param(
    "ssssi",
    $_POST['name'],
    $_POST['email'],
    $_POST['phone'],
    $_POST['gender'],
    $_SESSION['user_id']
);
$stmt->execute();

$_SESSION['success'] = "Profile updated";
header("Location: ../settings.php");