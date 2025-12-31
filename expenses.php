<?php
require_once 'inc/auth.php';
require_once 'inc/db.php';
require_once 'inc/functions.php';

$userId = $_SESSION['user_id'];
$currentMonth = date('Y-m');

/* ===============================
   DATE RANGE LOGIC (UI CONCERN)
================================ */
$range = $_GET['range'] ?? 'today';
$from  = $_GET['from'] ?? '';
$to    = $_GET['to'] ?? '';

switch ($range) {
    case 'today':
        $from = $to = date('Y-m-d');
        break;

    case '1w':
        $from = date('Y-m-d', strtotime('-7 days'));
        $to   = date('Y-m-d');
        break;

    case '1m':
        $from = date('Y-m-d', strtotime('-1 month'));
        $to   = date('Y-m-d');
        break;

    case '3m':
        $from = date('Y-m-d', strtotime('-3 months'));
        $to   = date('Y-m-d');
        break;

    case '6m':
        $from = date('Y-m-d', strtotime('-6 months'));
        $to   = date('Y-m-d');
        break;

    case '1y':
        $from = date('Y-m-d', strtotime('-1 year'));
        $to   = date('Y-m-d');
        break;

    case 'custom':
        // Use from & to as provided
        break;
}

/* ===============================
   BUILD FILTER (SERVICE LAYER)
================================ */
list($where, $params, $types) = buildExpenseFilter($userId, [
    'from' => $from,
    'to'   => $to,
    'q'    => $_GET['q'] ?? ''
]);

/* ===============================
   DATA FETCH (SERVICE LAYER)
================================ */
$totalExpenses = getTotalExpenses($conn, $where, $types, $params);
$monthlyLimit  = getMonthlyLimit($conn, $userId, $currentMonth);
$remaining     = $monthlyLimit - $totalExpenses;

$expenses = getExpenses($conn, $where, $types, $params);
?>


<?php include 'inc/layout_top.php'; ?>
<?php include 'inc/sidebar.php'; ?>
   <!-- ✅ ADD THIS -->

<div class="main-content">

    <!-- TOP BAR -->
     <?php include 'inc/topbar.php'; ?>

    <div class="content">
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h5 class="mb-0">Expenses</h5>

            <button class="btn btn-primary"
                    data-bs-toggle="modal"
                    data-bs-target="#addExpenseModal">
                <i class="fa fa-plus me-1"></i> Add Expense
            </button>
        </div>

        <!-- SUMMARY -->
        <div class="row g-3 mb-4">
            <div class="col-md-4">
                <div class="card p-3 bg-soft-blue">
                    <div class="muted">Total Expenses</div>
                    <div class="metric">₹<?= formatINR($totalExpenses) ?></div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card p-3 bg-soft-yellow">
                    <div class="muted">Monthly Limit</div>
                    <div class="metric">₹<?= formatINR($monthlyLimit) ?></div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card p-3 bg-soft-green">
                    <div class="muted">Remaining</div>
                    <div class="metric <?= $remaining < 0 ? 'negative' : 'positive' ?>">
                        ₹<?= formatINR($remaining) ?>
                    </div>
                </div>
            </div>
        </div>

        <!-- FILTERS -->
        <form method="get">
        <div class="card p-3 mb-3">
            <div class="row g-3 align-items-end">

                <div class="col-md-3">
                    <label class="muted">Transactions</label>
                    <select name="range" id="range" class="form-control">
                        <option value="today" <?= $range=='today'?'selected':'' ?>>Today</option>
                        <option value="1w" <?= $range=='1w'?'selected':'' ?>>Last 1 Week</option>
                        <option value="1m" <?= $range=='1m'?'selected':'' ?>>Last 1 Month</option>
                        <option value="3m" <?= $range=='3m'?'selected':'' ?>>Last 3 Months</option>
                        <option value="6m" <?= $range=='6m'?'selected':'' ?>>Last 6 Months</option>
                        <option value="1y" <?= $range=='1y'?'selected':'' ?>>Last 1 Year</option>
                        <option value="custom" <?= $range=='custom'?'selected':'' ?>>Custom</option>
                    </select>
                </div>

                <div class="col-md-3 custom-date">
                    <label class="muted">From</label>
                    <input type="date"
                        name="from"
                        value="<?= $from ?>"
                        max="<?= date('Y-m-d') ?>"
                        class="form-control">
                </div>

                <div class="col-md-3 custom-date">
                    <label class="muted">To</label>
                    <input type="date"
                        name="to"
                        value="<?= $to ?>"
                        max="<?= date('Y-m-d') ?>"
                        class="form-control">
                </div>

                <div class="col-md-2">
                    <label class="muted">Search</label>
                    <input type="text"
                           name="q"
                           value="<?= htmlspecialchars($_GET['q'] ?? '') ?>"
                           class="form-control"
                           placeholder="Food, Travel, Reason">
                </div>

                <div class="col-md-1">
                    <button class="btn btn-dark w-100">Go</button>
                </div>

            </div>
        </div>
        </form>

        <!-- TABLE -->
        <div class="card p-4">
            <h6 class="mb-3">Expense History</h6>

            <div class="table-responsive">
                <table class="table table-sm align-middle">
                    <thead class="muted">
                        <tr>
                            <th>#</th>
                            <th>Date</th>
                            <th>Expense For</th>
                            <th>Amount</th>
                            <th>Necessity</th>
                            <th>Payment</th>
                            <th>Reason</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>

                    <?php if ($expenses->num_rows === 0): ?>
                        <tr>
                            <td colspan="7" class="text-center muted">
                                No expenses found
                            </td>
                        </tr>
                    <?php else: ?>
                        <?php $i = 1; while ($row = $expenses->fetch_assoc()): ?>
                        <tr>
                            <td><?= $i++ ?></td>
                            <td><?= date('d-M-Y', strtotime($row['expense_date'])) ?></td>
                            <td><?= htmlspecialchars($row['expense_for']) ?></td>
                            <td>₹<?= formatINR($row['amount']) ?></td>
                            <td><?= $row['necessity_rating'] ?> / 5</td>
                            <td>
                                <?= ucfirst($row['payment_type']) ?>
                                <?= $row['online_app'] ? '(' . htmlspecialchars($row['online_app']) . ')' : '' ?>
                            </td>
                            <td><?= htmlspecialchars($row['reason']) ?></td>
                            <td>
                                <button
                                    class="btn btn-sm btn-outline-primary view-expense"
                                    data-expense='<?= json_encode($row, JSON_HEX_APOS | JSON_HEX_QUOT) ?>'>
                                    <i class="fa fa-eye"></i>
                                </button>

                                <button class="btn btn-sm btn-outline-secondary">
                                    <i class="fa fa-pen"></i>
                                </button>

                                <button class="btn btn-sm btn-outline-danger">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                        <?php endwhile; ?>
                    <?php endif; ?>

                    </tbody>
                </table>
            </div>
        </div>

    </div>
</div>

<!-- JS: Show / Hide Custom Dates -->
<script>
const range = document.getElementById('range');
const customDates = document.querySelectorAll('.custom-date');

function toggleDates() {
    customDates.forEach(el => {
        el.style.display = range.value === 'custom' ? 'block' : 'none';
    });
}

range.addEventListener('change', toggleDates);
toggleDates();
</script>

<script>
document.querySelectorAll('.view-expense').forEach(btn => {
    btn.addEventListener('click', function () {
        const data = JSON.parse(this.dataset.expense);

        document.getElementById('v_date').innerText =
            new Date(data.expense_date).toLocaleDateString('en-IN');

        document.getElementById('v_for').innerText = data.expense_for;
        document.getElementById('v_amount').innerText = '₹' + data.amount;
        document.getElementById('v_necessity').innerText =
            data.necessity_rating + ' / 5';

        document.getElementById('v_payment').innerText =
            data.payment_type.charAt(0).toUpperCase() + data.payment_type.slice(1);

        document.getElementById('v_online').innerText =
            data.online_app ? data.online_app : '-';

        document.getElementById('v_reason').innerText =
            data.reason ? data.reason : '-';

        new bootstrap.Modal(
            document.getElementById('viewExpenseModal')
        ).show();
    });
});
</script>

<?php include 'inc/layout_bottom.php'; ?>