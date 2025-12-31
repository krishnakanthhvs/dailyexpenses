<?php
require_once 'inc/auth.php';
require_once 'inc/db.php';
require_once 'inc/functions.php';

$userId = $_SESSION['user_id'];

$goalCount = getGoalCount($conn, $userId);
$goals     = getGoals($conn, $userId);
?>

<?php include 'inc/layout_top.php'; ?>
<?php include 'inc/sidebar.php'; ?>

<div class="main-content">
<?php include 'inc/topbar.php'; ?>

<div class="content">

<!-- PAGE HEADER -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <h5 class="mb-0">Goals</h5>

    <button class="btn btn-primary"
            data-bs-toggle="modal"
            data-bs-target="#addGoalModal"
            <?= $goalCount >= 10 ? 'disabled' : '' ?>>
        <i class="fa fa-plus me-1"></i> Add Goal
    </button>
</div>

<?php if ($goalCount >= 10): ?>
<div class="alert alert-warning small">
    You can create a maximum of <strong>10 goals</strong>.
</div>
<?php endif; ?>

<!-- GOALS GRID -->
<div class="row g-4">

<?php if ($goalCount === 0): ?>
    <div class="col-12 text-center muted">
        No goals created yet
    </div>
<?php else: ?>

<?php while ($goal = $goals->fetch_assoc()): ?>
<div class="col-md-4">
<div class="card p-4 h-100 shadow-sm">

    <!-- CARD HEADER -->
    <div class="d-flex justify-content-between align-items-start mb-3">
        <div class="fs-3">
            <?= htmlspecialchars($goal['icon']) ?>
        </div>

        <div class="dropdown">
            <button class="btn btn-sm btn-light" data-bs-toggle="dropdown">
                <i class="fa fa-ellipsis-vertical"></i>
            </button>
            <ul class="dropdown-menu dropdown-menu-end">
                <li>
                    <a class="dropdown-item view-goal"
                       href="#"
                       data-goal='<?= json_encode($goal, JSON_HEX_APOS | JSON_HEX_QUOT) ?>'>
                        View
                    </a>
                </li>
                <li><a class="dropdown-item edit-goal" href="#">Edit</a></li>
                <li><a class="dropdown-item text-danger delete-goal" href="#">Delete</a></li>
            </ul>
        </div>
    </div>

    <!-- CONTENT -->
    <h6 class="mb-1"><?= htmlspecialchars($goal['goal_name']) ?></h6>
    <div class="muted mb-2"><?= htmlspecialchars($goal['goal_for']) ?></div>

    <div class="fw-bold mb-2">
        ₹<?= formatINR($goal['amount']) ?>
    </div>

    <div class="muted small mb-3">
        Target: <?= date('d M Y', strtotime($goal['target_date'])) ?>
    </div>

    <span class="badge <?= $goal['days_left'] > 0 ? 'bg-info-subtle text-dark' : 'bg-danger-subtle text-dark' ?>">
        <?= $goal['days_left'] > 0 ? $goal['days_left'].' days left' : 'Due / Passed' ?>
    </span>

</div>
</div>
<?php endwhile; ?>

<?php endif; ?>
</div>
</div>
</div>

<!-- ADD GOAL MODAL -->
<div class="modal fade" id="addGoalModal" tabindex="-1">
<div class="modal-dialog modal-lg">
<div class="modal-content">

<form method="post" action="api/save_goal.php">

<div class="modal-header">
    <h5>Add Goal</h5>
    <button class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">
<div class="row g-3">

    <div class="col-md-6">
        <label class="muted">Goal Name</label>
        <input type="text" name="goal_name" class="form-control" required>
    </div>

    <div class="col-md-6">
        <label class="muted">Target Date</label>
        <input type="date"
               name="target_date"
               min="<?= date('Y-m-d') ?>"
               class="form-control"
               required
               onchange="calculateDays(this)">
    </div>

    <div class="col-md-12">
        <div class="muted small" id="daysInfo"></div>
    </div>

    <div class="col-md-6">
        <label class="muted">Goal Type</label>
        <select name="goal_type" class="form-control">
            <option>Short Term</option>
            <option>Long Term</option>
        </select>
    </div>

    <div class="col-md-6">
        <label class="muted">Goal For</label>
        <input type="text" name="goal_for" class="form-control">
    </div>

    <div class="col-md-12">
        <label class="muted">Goal Description</label>
        <textarea name="goal_desc" class="form-control"></textarea>
    </div>

    <div class="col-md-6">
        <label class="muted">Icon / Emoji</label>
        <select name="icon" class="form-control">
            <option>🎯</option>
            <option>🏖️</option>
            <option>💍</option>
            <option>💻</option>
            <option>🏠</option>
            <option>🚗</option>
            <option>💰</option>
        </select>
    </div>

    <div class="col-md-6">
        <label class="muted">Target Amount</label>
        <input type="number" name="amount" class="form-control" required>
    </div>

    <div class="col-md-12">
        <label class="muted">Any Occasion?</label>
        <input type="text" name="occasion" class="form-control">
    </div>

</div>
</div>

<div class="modal-footer">
    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
    <button class="btn btn-primary">Save Goal</button>
</div>

</form>

</div>
</div>
</div>

<script>
function calculateDays(input) {
    const today  = new Date();
    const target = new Date(input.value);

    const diff = Math.ceil((target - today) / (1000 * 60 * 60 * 24));

    document.getElementById('daysInfo').innerText =
        diff > 0 ? diff + ' days to achieve this goal' : 'Date must be in future';
}
</script>

<?php include 'inc/layout_bottom.php'; ?>