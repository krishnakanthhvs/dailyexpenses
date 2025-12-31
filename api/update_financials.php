<?php
require_once '../inc/auth.php';
require_once '../inc/db.php';

$stmt = $conn->prepare("
    UPDATE users SET monthly_income=? WHERE id=?
");
$stmt->bind_param("di", $_POST['monthly_income'], $_SESSION['user_id']);
$stmt->execute();

header("Location: ../settings.php");