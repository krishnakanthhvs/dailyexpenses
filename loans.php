<?php
require_once 'inc/auth.php';
require_once 'inc/db.php';
require_once 'inc/functions.php';

$userId = $_SESSION['user_id'];

/* FETCH LOANS */
$stmt = $conn->prepare("
    SELECT *,
    (tenure_months - paid_months) AS remaining_months
    FROM loans
    WHERE user_id = ?
    ORDER BY created_at DESC
");
$stmt->bind_param("i", $userId);
$stmt->execute();
$loans = $stmt->get_result();
?>

<?php include 'inc/layout_top.php'; ?>
<?php include 'inc/sidebar.php'; ?>

<div class="main-content">
<?php include 'inc/topbar.php'; ?>

<div class="content">

<!-- HEADER -->
<div class="d-flex justify-content-between align-items-center mb-4">
    <h5 class="mb-0">Loans</h5>

    <button class="btn btn-primary"
            data-bs-toggle="modal"
            data-bs-target="#addLoanModal">
        <i class="fa fa-plus me-1"></i> Add Loan
    </button>
</div>

<!-- LOANS GRID -->
<div class="row g-4">

<?php if ($loans->num_rows === 0): ?>
    <div class="col-12 text-center muted">
        No loans added yet
    </div>
<?php else: ?>

<?php while ($loan = $loans->fetch_assoc()): ?>
<div class="col-md-4">
<div class="card p-4 h-100">

    <div class="d-flex justify-content-between mb-3">
        <h6 class="mb-0"><?= e($loan['loan_name']) ?></h6>

        <span class="badge <?= $loan['status']=='active'?'bg-warning':'bg-success' ?>">
            <?= ucfirst($loan['status']) ?>
        </span>
    </div>

    <div class="muted mb-2">
        <?= ucfirst($loan['lender_type']) ?> :
        <?= e($loan['lender_name']) ?>
    </div>

    <div class="mb-2">
        <strong>₹<?= formatINR($loan['principal']) ?></strong>
        <span class="muted small">(Principal)</span>
    </div>

    <div class="mb-2">
        EMI: <strong>₹<?= formatINR($loan['emi']) ?></strong>
    </div>

    <div class="muted small mb-2">
        Remaining: <?= $loan['remaining_months'] ?> months
    </div>

    <div class="d-flex gap-2 mt-3">
        <button class="btn btn-sm btn-outline-primary view-loan"
                data-loan='<?= json_encode($loan) ?>'>
            <i class="fa fa-eye"></i>
        </button>

        <button class="btn btn-sm btn-outline-secondary">
            <i class="fa fa-pen"></i>
        </button>

        <button class="btn btn-sm btn-outline-danger">
            <i class="fa fa-trash"></i>
        </button>
    </div>

</div>
</div>
<?php endwhile; ?>

<?php endif; ?>

</div>
</div>
</div>

<!-- ADD LOAN MODAL -->
<div class="modal fade" id="addLoanModal" tabindex="-1">
<div class="modal-dialog modal-lg">
<div class="modal-content">

<form method="post" action="api/save_loan.php">

<div class="modal-header">
    <h5>Add Loan</h5>
    <button class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">
<div class="row g-3">

    <div class="col-md-6">
        <label class="muted">Loan Name</label>
        <input type="text" name="loan_name" class="form-control" required>
    </div>

    <div class="col-md-6">
        <label class="muted">Lender Type</label>
        <select name="lender_type" id="lenderType" class="form-control">
            <option value="bank">Bank</option>
            <option value="other">Other</option>
        </select>
    </div>

    <div class="col-md-6">
        <label class="muted">Bank / Person Name</label>
        <input type="text" name="lender_name" class="form-control" required>
    </div>

    <div class="col-md-6">
        <label class="muted">Principal Amount</label>
        <input type="number" name="principal" id="principal" class="form-control" required>
    </div>

    <div class="col-md-6">
        <label class="muted">Interest Rate (%)</label>
        <input type="number" step="0.01" id="interest" name="interest_rate" class="form-control">
    </div>

    <div class="col-md-6">
        <label class="muted">Tenure (Months)</label>
        <input type="number" id="tenure" name="tenure_months" class="form-control">
    </div>

    <div class="col-md-6">
        <label class="muted">Start Date</label>
        <input type="date" name="start_date" class="form-control" required>
    </div>

    <div class="col-md-6">
        <label class="muted">Calculated EMI</label>
        <input type="text" id="emi" class="form-control" readonly>
    </div>

</div>
</div>

<div class="modal-footer">
    <button class="btn btn-primary">Save Loan</button>
</div>

</form>

</div>
</div>
</div>

<script>
function calcEMI() {
    const P = parseFloat(principal.value || 0);
    const r = parseFloat(interest.value || 0) / 12 / 100;
    const n = parseInt(tenure.value || 0);

    if (!P || !r || !n) return emi.value = '';

    const emiVal = (P * r * Math.pow(1+r, n)) / (Math.pow(1+r, n) - 1);
    emi.value = emiVal.toFixed(2);
}

principal.oninput = interest.oninput = tenure.oninput = calcEMI;
</script>

<?php include 'inc/layout_bottom.php'; ?>