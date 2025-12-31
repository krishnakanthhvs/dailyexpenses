<?php
require_once 'inc/db.php';

$error = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $login    = trim($_POST['login'] ?? '');
    $password = $_POST['password'] ?? '';

    if ($login === '' || $password === '') {
        $error = "All fields are required";
    } else {

        $sql = "SELECT * FROM users 
                WHERE username = ? OR email = ?
                LIMIT 1";

        $stmt = $conn->prepare($sql);
        $stmt->bind_param("ss", $login, $login);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 0) {
            $error = "User not found";
        } else {

            $user = $result->fetch_assoc();

            if (!password_verify($password, $user['password'])) {
                $error = "Incorrect password";
            } else {
                // LOGIN SUCCESS
                $_SESSION['user_id']  = $user['id'];
                $_SESSION['name']     = $user['name'];
                $_SESSION['username'] = $user['username'];
                $_SESSION['email']    = $user['email'];

                header("Location: dashboard.php");
                exit;
            }
        }
    }
}
?>

<!doctype html>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body class="bg-light d-flex align-items-center" style="height:100vh">

<div class="card p-4 col-md-4 mx-auto">
    <h4 class="mb-3">Login</h4>

    <?php if ($error): ?>
        <div class="alert alert-danger"><?= htmlspecialchars($error) ?></div>
    <?php endif; ?>

    <form method="post">
        <input name="login"
               class="form-control mb-2"
               placeholder="Username or Email"
               required>

        <input name="password"
               type="password"
               class="form-control mb-3"
               placeholder="Password"
               required>

        <button class="btn btn-primary w-100">Login</button>
    </form>
</div>

</body>
</html>