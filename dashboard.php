<?php require_once 'inc/auth.php'; ?>
<?php include 'inc/layout_top.php'; ?>
<?php include 'inc/sidebar.php'; ?>

<?php 

require_once 'inc/functions.php';

$userId = $_SESSION['user_id'];

$monthExpenses = getMonthlyExpenses($conn, $userId);
$avgSpend      = getAvgDailySpend($monthExpenses);
$limit         = getMonthlyLimitAmount($conn, $userId);
$savings       = $limit - $monthExpenses;

$goals         = getGoalsAchieved($conn, $userId);
$recent        = getRecentExpenses($conn, $userId);

list($lineLabels, $lineData) = getDailyExpenseChart($conn, $userId);
list($pieLabels,  $pieData)  = getCategoryPieChart($conn, $userId);

?>

<?php if (!$hasMonthlyLimit): ?>
<script>
document.addEventListener('DOMContentLoaded', function () {
    const modal = new bootstrap.Modal(
        document.getElementById('monthlyLimitModal'),
        { backdrop: 'static', keyboard: false }
    );
    modal.show();
});
</script>
<?php endif; ?>

<div class="main-content">

    <!-- TOP BAR -->
    <div class="topbar px-4">
        <h4 class="mb-0">Dashboard</h4>

        <div class="d-flex align-items-center gap-3">
            <span class="muted">
                Logged in as: <strong>Krishna Kanth</strong>
            </span>
            <a href="logout.php" class="btn btn-outline-danger btn-sm">Logout</a>
        </div>
    </div>

    <!-- PAGE CONTENT -->
    <div class="content">

        <!-- WELCOME + SUMMARY -->
        <div class="card p-4 mb-4 bg-soft-gray">
            <h5 class="mb-1">Welcome back, Krishna 👋</h5>
            <p class="muted mb-4">Here’s a quick look at your finances</p>

            <div class="row g-3">
                <div class="col-md-3">
                    <div class="card p-3 bg-soft-blue">
                        <div class="muted">This Month Expenses</div>
                        <div class="metric">₹<?= formatINR($monthExpenses) ?></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card p-3 bg-soft-yellow">
                        <div class="muted">Avg Daily Spend</div>
                        <div class="metric">₹<?= formatINR($avgSpend) ?></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card p-3 bg-soft-green">
                        <div class="muted">Savings This Month</div>
                        <div class="metric positive">₹<?= formatINR($savings) ?></div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card p-3 bg-soft-purple">
                        <div class="muted">Goals Achieved</div>
                        <div class="metric"><?= $goals['achieved'] ?> / <?= $goals['total'] ?></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- CHARTS -->
        <div class="row g-4 mb-4">

            <!-- LINE CHART -->
            <div class="col-md-6">
                <div class="card p-4 bg-soft-gray">
                    <h6>Daily Expenses (This Month)</h6>
                    <div style="height:260px">
                        <canvas id="expenseChart"></canvas>
                    </div>
                </div>
            </div>

            <!-- PIE CHART -->
            <div class="col-md-6">
                <div class="card p-4 bg-soft-gray">
                    <h6>Expense Breakdown (This Month)</h6>
                    <div style="height:260px; display:flex; align-items:center; justify-content:center">
                        <canvas id="categoryPie"></canvas>
                    </div>
                </div>
            </div>

        </div>

        <!-- GOALS + RECENT EXPENSES -->
        <div class="row g-4 align-items-stretch">

            <div class="col-md-5">
                <div class="card p-4 h-100 bg-soft-green d-flex flex-column">
                    <h6>Goal Progress</h6>

                    <div class="mt-2" style="flex:1">
                        <div class="d-flex justify-content-between muted mb-1">
                            <span>Emergency Fund</span><span>70%</span>
                        </div>
                        <div class="progress">
                            <div class="progress-bar bg-success" style="width:70%"></div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <div class="d-flex justify-content-between muted mb-1">
                            <span>Vacation</span><span>40%</span>
                        </div>
                        <div class="progress">
                            <div class="progress-bar bg-info" style="width:40%"></div>
                        </div>
                    </div>

                    <div>
                        <div class="d-flex justify-content-between muted mb-1">
                            <span>New Laptop</span><span>20%</span>
                        </div>
                        <div class="progress">
                            <div class="progress-bar bg-warning" style="width:20%"></div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-md-7">
                <div class="card p-4 h-100 bg-soft-blue d-flex flex-column">
                    <h6>Recent Expenses</h6>

                    <div class="table-responsive mt-2" style="flex:1; overflow:auto">
                        <table class="table table-sm align-middle mb-0">
                            <thead class="muted">
                                <tr>
                                    <th>Date</th>
                                    <th>Category</th>
                                    <th>Description</th>
                                    <th class="text-end">Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                                <?php while ($r = $recent->fetch_assoc()): ?>
                                    <tr>
                                        <td><?= date('d M', strtotime($r['expense_date'])) ?></td>
                                        <td><?= htmlspecialchars($r['expense_for']) ?></td>
                                        <td><?= htmlspecialchars($r['reason']) ?></td>
                                        <td class="text-end">₹<?= formatINR($r['amount']) ?></td>
                                    </tr>
                                <?php endwhile; ?>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>

        </div>

    </div>
</div>

<!-- CHART JS -->
<script>
new Chart(expenseChart, {
    type: 'line',
    data: {
        labels: <?= json_encode($lineLabels) ?>,
        datasets: [{
            data: <?= json_encode($lineData) ?>,
            borderColor: '#2563eb',
            backgroundColor: 'rgba(37,99,235,.15)',
            fill: true,
            tension: 0.4
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        plugins: { legend: { display: false } }
    }
});

new Chart(categoryPie, {
    type: 'pie',
    data: {
        labels: <?= json_encode($pieLabels) ?>,
        datasets: [{
            data: <?= json_encode($pieData) ?>,
            backgroundColor: [
                '#2563eb','#16a34a','#f59e0b','#ec4899','#6366f1'
            ]
        }]
    },
    options: {
        responsive: true,
        maintainAspectRatio: false,
        radius: '80%',
        plugins: {
            legend: { position: 'bottom' }
        }
    }
});
</script>

<?php include 'inc/layout_bottom.php'; ?>