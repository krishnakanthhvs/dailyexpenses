<?php
require_once '../inc/auth.php';
require_once '../inc/db.php';

$current = $_POST['current_password'];
$new     = $_POST['new_password'];
$confirm = $_POST['confirm_password'];

if ($new !== $confirm) {
    die("Passwords do not match");
}

$stmt = $conn->prepare("SELECT password FROM users WHERE id=?");
$stmt->bind_param("i", $_SESSION['user_id']);
$stmt->execute();
$stmt->bind_result($hash);
$stmt->fetch();

if (!password_verify($current, $hash)) {
    die("Incorrect current password");
}

$newHash = password_hash($new, PASSWORD_DEFAULT);

$stmt = $conn->prepare("UPDATE users SET password=? WHERE id=?");
$stmt->bind_param("si", $newHash, $_SESSION['user_id']);
$stmt->execute();

header("Location: ../settings.php");