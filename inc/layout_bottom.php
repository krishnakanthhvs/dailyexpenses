<?php if (isset($hasMonthlyLimit) && !$hasMonthlyLimit): ?>
<div class="modal fade" id="monthlyLimitModal" tabindex="-1">
<div class="modal-dialog">
<div class="modal-content">

<form method="post" action="save_monthly_limit.php">

<div class="modal-header">
    <h5>Set Monthly Expense Limit</h5>
</div>

<div class="modal-body">
    <p class="text-danger fw-semibold">⚠ Important</p>
    <p class="muted">
        You are setting the expense limit for
        <strong><?= date('F Y') ?></strong>.
    </p>
    <p class="muted">
        <strong>Once set, this cannot be changed for this month.</strong>
    </p>

    <input type="number"
           name="limit_amount"
           class="form-control"
           placeholder="Enter monthly limit"
           required>
</div>

<div class="modal-footer">
    <button class="btn btn-primary w-100">
        Confirm & Continue
    </button>
</div>

</form>

</div>
</div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
    const modal = new bootstrap.Modal(
        document.getElementById('monthlyLimitModal'),
        {
            backdrop: 'static',
            keyboard: false
        }
    );
    modal.show();

    // Disable background interactions
    document.body.classList.add('modal-open');
});
</script>
<?php endif; ?>


<!-- VIEW EXPENSE MODAL -->
<div class="modal fade" id="viewExpenseModal" tabindex="-1">
<div class="modal-dialog modal-lg">
<div class="modal-content">

<div class="modal-header">
    <h5>Expense Details</h5>
    <button class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">
    <div class="row g-3">
        <div class="col-md-4">
            <label class="muted">Date</label>
            <div class="fw-semibold" id="v_date"></div>
        </div>

        <div class="col-md-4">
            <label class="muted">Expense For</label>
            <div class="fw-semibold" id="v_for"></div>
        </div>

        <div class="col-md-4">
            <label class="muted">Amount</label>
            <div class="fw-semibold" id="v_amount"></div>
        </div>

        <div class="col-md-4">
            <label class="muted">Necessity</label>
            <div class="fw-semibold" id="v_necessity"></div>
        </div>

        <div class="col-md-4">
            <label class="muted">Payment Type</label>
            <div class="fw-semibold" id="v_payment"></div>
        </div>

        <div class="col-md-4">
            <label class="muted">Online App / Bank</label>
            <div class="fw-semibold" id="v_online"></div>
        </div>

        <div class="col-md-12">
            <label class="muted">Reason</label>
            <div class="fw-semibold" id="v_reason"></div>
        </div>
    </div>
</div>

<div class="modal-footer">
    <button class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
</div>

</div>
</div>
</div>


<!-- ADD EXPENSE MODAL -->
<div class="modal fade" id="addExpenseModal" tabindex="-1">
<div class="modal-dialog modal-lg">
<div class="modal-content">

<form method="post" action="api/save_expense.php">

<div class="modal-header">
    <h5>Add Expense</h5>
    <button class="btn-close" data-bs-dismiss="modal"></button>
</div>

<div class="modal-body">
<div class="row g-3">

    <div class="col-md-6">
        <label class="muted">Date</label>
        <input type="date"
               name="expense_date"
               max="<?= date('Y-m-d') ?>"
               class="form-control"
               required>
    </div>

    <div class="col-md-6">
        <label class="muted">Expense For</label>
        <input type="text"
               name="expense_for"
               class="form-control"
               required>
    </div>

    <div class="col-md-6">
        <label class="muted">Amount</label>
        <input type="number"
               name="amount"
               step="0.01"
               class="form-control"
               required>
    </div>

    <div class="col-md-6">
        <label class="muted">Necessity (1–5)</label>
        <select name="necessity_rating" class="form-control">
            <option value="1">1 – Not Needed</option>
            <option value="2">2</option>
            <option value="3">3</option>
            <option value="4">4</option>
            <option value="5">5 – Essential</option>
        </select>
    </div>

    <div class="col-md-6">
        <label class="muted">Payment Type</label>
        <select name="payment_type" id="payment_type" class="form-control" required>
            <option value="cash">Cash</option>
            <option value="online">Online</option>
        </select>
    </div>

    <div class="col-md-6" id="online_app_wrap" style="display:none">
        <label class="muted">Online App / Bank</label>
        <select name="online_app" id="online_app" class="form-control">
            <option value="">Select</option>
            <option>PhonePe</option>
            <option>Google Pay</option>
            <option>Paytm</option>
            <option>ICICI</option>
            <option>SBI</option>
            <option>HDFC</option>
            <option>Jupiter</option>
        </select>
    </div>

    <div class="col-md-12">
        <label class="muted">Reason</label>
        <textarea name="reason" class="form-control"></textarea>
    </div>

</div>
</div>

<div class="modal-footer">
    <button class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
    <button class="btn btn-primary">Save Expense</button>
</div>

</form>

</div>
</div>
</div>

<script>
document.getElementById('payment_type')?.addEventListener('change', function () {
    const wrap = document.getElementById('online_app_wrap');
    const app  = document.getElementById('online_app');

    if (this.value === 'online') {
        wrap.style.display = 'block';
        app.required = true;
    } else {
        wrap.style.display = 'none';
        app.required = false;
        app.value = '';
    }
});
</script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>