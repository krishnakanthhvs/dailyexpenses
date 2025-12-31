<?php
$currentPage = basename($_SERVER['PHP_SELF']);
?>

<aside class="sidebar">
    <div class="sidebar-header">
        My Expenses
    </div>

    <nav class="sidebar-nav">

        <a href="dashboard.php"
           class="<?= in_array($currentPage, ['index.php','dashboard.php']) ? 'active' : '' ?>">
            <i class="fa fa-house"></i> Dashboard
        </a>

        <a href="expenses.php"
           class="<?= $currentPage === 'expenses.php' ? 'active' : '' ?>">
            <i class="fa fa-wallet"></i> Expenses
        </a>

        <a href="goals.php"
           class="<?= $currentPage === 'goals.php' ? 'active' : '' ?>">
            <i class="fa fa-bullseye"></i> Goals
        </a>

        <a href="savings.php"
           class="<?= $currentPage === 'savings.php' ? 'active' : '' ?>">
            <i class="fa fa-piggy-bank"></i> Savings
        </a>

        <a href="loans.php"
           class="<?= $currentPage === 'loans.php' ? 'active' : '' ?>">
            <i class="fa fa-university"></i> Loans
        </a>

        <a href="settings.php"
           class="<?= $currentPage === 'settings.php' ? 'active' : '' ?>">
            <i class="fa fa-gear"></i> Settings
        </a>

    </nav>
</aside>