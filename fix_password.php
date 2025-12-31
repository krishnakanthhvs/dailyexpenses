<?php
$pdo = new PDO(
    "mysql:host=localhost;dbname=expense_dashboard",
    "root",
    "root",
    [PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION]
);

$email = 'admin@example.com';
$newPassword = 'password123';

$hash = password_hash($newPassword, PASSWORD_DEFAULT);

$stmt = $pdo->prepare("UPDATE users SET password = ? WHERE email = ?");
$stmt->execute([$hash, $email]);

echo "Password updated successfully.<br>";
echo "Email: $email<br>";
echo "Password: $newPassword<br>";
echo "Hash: $hash<br>";