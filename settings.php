<?php
require_once 'inc/auth.php';
require_once 'inc/db.php';
require_once 'inc/functions.php';

$userId = $_SESSION['user_id'];

/* FETCH USER */
$stmt = $conn->prepare("
    SELECT username, name, email, phone, gender, monthly_income
    FROM users
    WHERE id = ?
");
$stmt->bind_param("i", $userId);
$stmt->execute();
$user = $stmt->get_result()->fetch_assoc();
?>

<?php include 'inc/layout_top.php'; ?>
<?php include 'inc/sidebar.php'; ?>

<div class="main-content">
<?php include 'inc/topbar.php'; ?>

<div class="content">

<h5 class="mb-4">Settings</h5>

<!-- ================= PROFILE ================= -->
<div class="card p-4 mb-4">
<h6 class="mb-3">Profile Information</h6>

<form method="post" action="api/update_profile.php">
<div class="row g-3">

    <div class="col-md-6">
        <label class="muted">Full Name</label>
        <input type="text" name="name"
               value="<?= htmlspecialchars($user['name']) ?>"
               class="form-control" required>
    </div>

    <div class="col-md-6">
        <label class="muted">Username</label>
        <input type="text" value="<?= htmlspecialchars($user['username']) ?>"
               class="form-control" disabled>
    </div>

    <div class="col-md-6">
        <label class="muted">Email</label>
        <input type="email" name="email"
            value="<?= htmlspecialchars($user['email'] ?? '') ?>"
            class="form-control">
    </div>

    <div class="col-md-6">
        <label class="muted">Phone</label>
        <input type="text" name="phone"
                value="<?= htmlspecialchars($user['phone'] ?? '') ?>"
                class="form-control">
    </div>

    <div class="col-md-6">
        <label class="muted">Gender</label>
        <select name="gender" class="form-control">
            <option value="">Select</option>
            <option value="male"   <?= ($user['gender'] ?? '')=='male'?'selected':'' ?>>Male</option>
            <option value="female" <?= ($user['gender'] ?? '')=='female'?'selected':'' ?>>Female</option>
            <option value="other"  <?= ($user['gender'] ?? '')=='other'?'selected':'' ?>>Other</option>
        </select>
    </div>

</div>

<div class="mt-3 text-end">
    <button class="btn btn-primary">Save Profile</button>
</div>
</form>
</div>

<!-- ================= FINANCIAL ================= -->
<div class="card p-4 mb-4">
<h6 class="mb-3">Financial Defaults</h6>

<form method="post" action="api/update_financials.php">

<label class="muted">Monthly Income (default)</label>
<input type="number" name="monthly_income"
       value="<?= $user['monthly_income'] ?>"
       class="form-control mb-3">

<p class="muted small">
Used for savings & monthly calculations.
</p>

<button class="btn btn-primary">Update Financials</button>
</form>
</div>

<!-- ================= SECURITY ================= -->
<div class="card p-4 mb-4">
<h6 class="mb-3">Security</h6>

<form method="post" action="api/change_password.php">

<div class="mb-3">
    <label class="muted">Current Password</label>
    <input type="password" name="current_password" class="form-control" required>
</div>

<div class="mb-3">
    <label class="muted">New Password</label>
    <input type="password" name="new_password" class="form-control" required>
</div>

<div class="mb-3">
    <label class="muted">Confirm New Password</label>
    <input type="password" name="confirm_password" class="form-control" required>
</div>

<button class="btn btn-warning">Change Password</button>
</form>
</div>

<!-- ================= APP PREFERENCES ================= -->
<div class="card p-4 mb-4">
<h6 class="mb-3">App Preferences</h6>

<form>
<div class="form-check mb-2">
    <input class="form-check-input" type="checkbox" checked>
    <label class="form-check-label muted">
        Show reminders for goals
    </label>
</div>

<div class="form-check mb-2">
    <input class="form-check-input" type="checkbox" checked>
    <label class="form-check-label muted">
        Highlight overspending
    </label>
</div>

<p class="muted small">
(Preferences will be activated in future versions)
</p>
</form>
</div>

<!-- ================= DANGER ZONE ================= -->
<div class="card p-4 border border-danger">
<h6 class="mb-3 text-danger">Danger Zone</h6>

<p class="muted">
Deleting your account will remove all expenses, goals, and savings permanently.
</p>

<button class="btn btn-outline-danger"
        onclick="confirm('Are you absolutely sure?')">
    Delete Account
</button>
</div>

</div>
</div>

<?php include 'inc/layout_bottom.php'; ?>