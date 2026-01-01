<?php
require_once __DIR__ . '/../inc/db.php';

date_default_timezone_set('Asia/Kolkata');

/* ===============================
   FETCH USERS WITH TOKEN
================================ */
$result = $conn->query("
    SELECT id, name, email, api_token
    FROM users
    WHERE email IS NOT NULL
      AND api_token IS NOT NULL
");

if (!$result || $result->num_rows === 0) {
    exit;
}

/* ===============================
   EMAIL TEMPLATE
================================ */
$template = file_get_contents(__DIR__ . '/templates/daily_expense_email.html');

while ($user = $result->fetch_assoc()) {

    $link = "http://dailyexpenses.mydailydiary.space/forms/quick-expense.php?token="
          . urlencode($user['api_token']);

    $body = str_replace(
        ['{{NAME}}', '{{LINK}}'],
        [htmlspecialchars($user['name'] ?: 'there'), $link],
        $template
    );

    $headers  = "MIME-Version: 1.0\r\n";
    $headers .= "Content-type:text/html;charset=UTF-8\r\n";
    $headers .= "From: My Daily Diary <no-reply@mydailydiary.space>\r\n";

    mail(
        $user['email'],
        "🧾 Don't forget to log today's expenses",
        $body,
        $headers
    );
}