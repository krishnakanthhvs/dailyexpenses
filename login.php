<?php
require_once 'inc/db.php';

if (session_status() === PHP_SESSION_NONE) {
    session_start();
}

$error = '';
$login = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $login    = trim($_POST['login'] ?? '');
    $password = $_POST['password'] ?? '';

    if ($login === '' || $password === '') {
        $error = "All fields are required";
    } else {

        $stmt = $conn->prepare("
            SELECT id, username, name, email, password
            FROM users
            WHERE username = ? OR email = ?
            LIMIT 1
        ");
        $stmt->bind_param("ss", $login, $login);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows === 0) {
            $error = "Invalid username or email";
        } else {
            $user = $result->fetch_assoc();

            if (!password_verify($password, $user['password'])) {
                $error = "Incorrect password";
            } else {
                // ✅ LOGIN SUCCESS
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

include 'inc/layout_top.php';
?>

<div class="d-flex justify-content-center align-items-center min-vh-100">

    <div class="login-card row g-0">

        <!-- LEFT PANEL -->
        <div class="col-md-6 login-left px-4 px-md-5">
            <h3>Track & Control Your Daily Expenses</h3>
            <p>
                Monitor your spending, set monthly limits,
                achieve goals, and build smarter financial habits with ease.
            </p>

            <!-- <img src="assets/img/login.png" alt="Daily Expenses"> -->
        </div>

        <!-- RIGHT PANEL -->
        <div class="col-md-6 login-right px-4 px-md-5">

            <div class="brand mb-4 d-flex align-items-center gap-2">
                <i class="fa-solid fa-diamond"></i>
                MY DAILY DIARY
            </div>

            <h4 class="mb-4">Login</h4>

            <?php if ($error): ?>
                <div class="alert alert-danger">
                    <?= htmlspecialchars($error) ?>
                </div>
            <?php endif; ?>

            <form method="post" novalidate>

                <div class="mb-3">
                    <label class="form-label muted">Username or Email</label>
                    <input
                        type="text"
                        name="login"
                        class="form-control"
                        placeholder="Enter Username or Email"
                        value="<?= htmlspecialchars($login) ?>"
                        required
                    >
                </div>

                <div class="mb-3">
                    <label class="form-label muted">Password</label>
                    <input
                        type="password"
                        name="password"
                        class="form-control"
                        placeholder="Enter password"
                        required
                    >
                </div>

                <div class="d-flex justify-content-between align-items-center mb-4">
                    <div class="form-check">
                        <input class="form-check-input" type="checkbox" id="remember">
                        <label class="form-check-label muted" for="remember">
                            Remember me
                        </label>
                    </div>
                    <a href="#" class="small-link">Forgot Password?</a>
                </div>

                <button type="submit" class="btn w-100 login-btn">
                    LOGIN
                </button>

            </form>
        </div>

    </div>

</div>
<?php include 'inc/layout_bottom.php'; ?>