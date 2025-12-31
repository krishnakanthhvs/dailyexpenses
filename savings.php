<?php
require_once 'inc/auth.php';
require_once 'inc/db.php';
require_once 'inc/functions.php';

$userId = $_SESSION['user_id'];
$currentMonth = date('Y-m');

/* ===============================
   FETCH SAVINGS
================================ */
$stmt = $conn->prepare("
    SELECT *
    FROM savings
    WHERE user_id = ?
    ORDER BY month_year DESC
");
$stmt->bind_param("i", $userId);
$stmt->execute();
$savings = $stmt->get_result();

/* ===============================
   CURRENT MONTH CHECK
================================ */
$stmt = $conn->prepare("
    SELECT *
    FROM savings
    WHERE user_id = ? AND month_year = ?
");
$stmt->bind_param("is", $userId, $currentMonth);
$stmt->execute();
$currentSaving = $stmt->get_result()->fetch_assoc();
?>

<?php include 'inc/layout_top.php'; ?>
<?php include 'inc/sidebar.php'; ?>

<div class="main-content">
<?php include 'inc/topbar.php'; ?>

<div class="content">

<!-- HEADER -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <h5 class="mb-0">Savings</h5>

    <?php if (!$currentSaving): ?>
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addSavingModal">
            <i class="fa fa-plus me-1"></i> Add This Month Income
        </button>
    <?php endif; ?>
</div>

<!-- CURRENT MONTH SUMMARY -->
<?php if ($currentSaving): ?>
<div class="row g-3 mb-4">
    <div class="col-md-4">
        <div class="card p-3 bg-soft-blue">
            <div class="muted">Monthly Income</div>
            <div class="metric">₹<?= formatINR($currentSaving['income']) ?></div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card p-3 bg-soft-green">
            <div class="muted">Saved Amount</div>
            <div class="metric positive">₹<?= formatINR($currentSaving['saved_amount']) ?></div>
        </div>
    </div>

    <div class="col-md-4">
        <div class="card p-3 bg-soft-yellow">
            <div class="muted">Savings %</div>
            <div class="metric">
                <?= round(($currentSaving['saved_amount'] / $currentSaving['income']) * 100) ?>%
            </div>
        </div>
    </div>
</div>
<?php endif; ?>

<!-- SAVINGS HISTORY -->
<div class="card p-4">
    <h6 class="mb-3">Savings History</h6>

    <div class="table-responsive">
        <table class="table table-sm align-middle">
            <thead class="muted">
                <tr>
                    <th>Month</th>
                    <th>Income</th>
                    <th>Saved</th>
                    <th>Savings %</th>
                    <th>Note</th>
                </tr>
            </thead>
            <tbody>

            <?php if ($savings->num_rows === 0): ?>
                <tr>
                    <td colspan="5" class="text-center muted">No savings data</td>
                </tr>
            <?php else: ?>
                <?php while ($row = $savings->fetch_assoc()): ?>
                <tr>
                    <td><?= date('F Y', strtotime($row['month_year'].'-01')) ?></td>
                    <td>₹<?= formatINR($row['income']) ?></td>
                    <td>₹<?= formatINR($row['saved_amount']) ?></td>
                    <td>
                        <?= round(($row['saved_amount'] / $row['income']) * 100) ?>%
                    </td>
                    <td><?= htmlspecialchars($row['note']) ?></td>
                </tr>
                <?php endwhile; ?>
            <?php endif; ?>

            </tbody>
        </table>
    </div>
</div>

</div>
</div>

<!-- ADD SAVING MODAL -->
<div class="modal fade" id="addSavingModal" tabindex="-1">
<div class="modal-dialog">
<div class="modal-content">

<form method="post" action="api/save_saving.php">

<div class="modal-header">
    <h5>Add Monthly Income</h5>
    <button class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">
    <p class="muted small">
        This will be locked for <strong><?= date('F Y') ?></strong>
    </p>

    <label class="muted">Monthly Income</label>
    <input type="number" name="income" class="form-control mb-3" required>

    <label class="muted">Initial Saved Amount</label>
    <input type="number" name="saved_amount" class="form-control mb-3">

    <label class="muted">Note</label>
    <textarea name="note" class="form-control"></textarea>
</div>

<div class="modal-footer">
    <button class="btn btn-primary w-100">Save</button>
</div>

</form>

</div>
</div>
</div>

<?php include 'inc/layout_bottom.php'; ?>