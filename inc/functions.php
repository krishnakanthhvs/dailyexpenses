<?php
/**
 * Central application logger
 *
 * @param string $message
 * @param string $level info|warning|error|debug
 * @param array  $context optional extra data
 */
function appLog(string $message, string $level = 'info', array $context = []): void
{
    $logDir  = __DIR__ . '/../logs';
    $logFile = $logDir . '/error.log';

    // Ensure log directory exists
    if (!is_dir($logDir)) {
        mkdir($logDir, 0755, true);
    }

    // Timestamp
    $time = date('Y-m-d H:i:s');

    // User info if available
    $user = $_SESSION['user_id'] ?? 'guest';

    // Context stringify
    $contextStr = !empty($context)
        ? json_encode($context, JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES)
        : '';

    $logLine = "[{$time}] [{$level}] [user:{$user}] {$message} {$contextStr}" . PHP_EOL;

    error_log($logLine, 3, $logFile);
}

/* ===============================
   HELPERS
================================ */

function formatINR($amount)
{
    $amount = round($amount, 2);
    $parts = explode('.', $amount);
    $integer = $parts[0];
    $decimal = $parts[1] ?? '00';

    $lastThree = substr($integer, -3);
    $rest = substr($integer, 0, -3);

    if ($rest !== '') {
        $rest = preg_replace("/\B(?=(\d{2})+(?!\d))/", ",", $rest);
        return $rest . ',' . $lastThree . '.' . $decimal;
    }

    return $lastThree . '.' . $decimal;
}


/* ===============================
   MONTHLY LIMIT
================================ */

function getMonthlyLimit(mysqli $conn, int $userId, string $month)
{
    $stmt = $conn->prepare("
        SELECT limit_amount
        FROM monthly_limits
        WHERE user_id = ? AND month_year = ?
    ");
    $stmt->bind_param("is", $userId, $month);
    $stmt->execute();
    $stmt->bind_result($limit);
    $stmt->fetch();
    $stmt->close();

    return $limit ?? 0;
}

function hasMonthlyLimit(mysqli $conn, int $userId, string $month): bool
{
    $stmt = $conn->prepare("
        SELECT 1 FROM monthly_limits
        WHERE user_id = ? AND month_year = ?
    ");
    $stmt->bind_param("is", $userId, $month);
    $stmt->execute();
    $stmt->store_result();
    $exists = $stmt->num_rows > 0;
    $stmt->close();

    return $exists;
}


/* ===============================
   EXPENSE FILTER BUILDER
================================ */

function buildExpenseFilter(int $userId, array $input): array
{
    $where  = " WHERE user_id = ? ";
    $params = [$userId];
    $types  = "i";

    if (!empty($input['from'])) {
        $where .= " AND expense_date >= ? ";
        $params[] = $input['from'];
        $types   .= "s";
    }

    if (!empty($input['to'])) {
        $where .= " AND expense_date <= ? ";
        $params[] = $input['to'];
        $types   .= "s";
    }

    if (!empty($input['q'])) {
        $where .= " AND (expense_for LIKE ? OR reason LIKE ?) ";
        $search = '%' . $input['q'] . '%';
        $params[] = $search;
        $params[] = $search;
        $types   .= "ss";
    }

    return [$where, $params, $types];
}


/* ===============================
   EXPENSE QUERIES
================================ */

function getTotalExpenses(mysqli $conn, string $where, string $types, array $params): float
{
    $sql = "SELECT IFNULL(SUM(amount),0) FROM expenses $where";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param($types, ...$params);
    $stmt->execute();
    $stmt->bind_result($total);
    $stmt->fetch();
    $stmt->close();

    return (float)$total;
}

function getExpenses(mysqli $conn, string $where, string $types, array $params)
{
    $sql = "SELECT * FROM expenses $where ORDER BY expense_date DESC";
    $stmt = $conn->prepare($sql);
    $stmt->bind_param($types, ...$params);
    $stmt->execute();
    return $stmt->get_result();
}

/* ===============================
   GOALS FUNCTIONS
================================ */

function getGoals(mysqli $conn, int $userId, int $limit = 10)
{
    $stmt = $conn->prepare("
        SELECT *,
               DATEDIFF(target_date, CURDATE()) AS days_left
        FROM goals
        WHERE user_id = ?
        ORDER BY target_date ASC
        LIMIT ?
    ");
    $stmt->bind_param("ii", $userId, $limit);
    $stmt->execute();
    return $stmt->get_result();
}

function getGoalCount(mysqli $conn, int $userId): int
{
    $stmt = $conn->prepare("SELECT COUNT(*) FROM goals WHERE user_id = ?");
    $stmt->bind_param("i", $userId);
    $stmt->execute();
    $stmt->bind_result($count);
    $stmt->fetch();
    $stmt->close();

    return (int)$count;
}

function e($value)
{
    return htmlspecialchars($value ?? '', ENT_QUOTES, 'UTF-8');
}

/* ==============================
   DASHBOARD METRICS
================================ */

function getMonthRange(): array {
    return [
        'start' => date('Y-m-01'),
        'end'   => date('Y-m-t')
    ];
}

function getMonthlyExpenses($conn, $userId) {
    $range = getMonthRange();

    $stmt = $conn->prepare("
        SELECT IFNULL(SUM(amount),0)
        FROM expenses
        WHERE user_id = ?
          AND expense_date BETWEEN ? AND ?
    ");
    $stmt->bind_param("iss", $userId, $range['start'], $range['end']);
    $stmt->execute();
    $stmt->bind_result($total);
    $stmt->fetch();
    return $total;
}

function getAvgDailySpend($total) {
    $days = (int) date('j'); // days passed in month
    return $days > 0 ? round($total / $days, 2) : 0;
}

function getMonthlyLimitAmount($conn, $userId) {
    $month = date('Y-m');

    $stmt = $conn->prepare("
        SELECT limit_amount
        FROM monthly_limits
        WHERE user_id = ? AND month_year = ?
    ");
    $stmt->bind_param("is", $userId, $month);
    $stmt->execute();
    $stmt->bind_result($limit);
    $stmt->fetch();

    return $limit ?? 0;
}

function getGoalsAchieved($conn, $userId) {
    $stmt = $conn->prepare("
        SELECT 
            SUM(target_date < CURDATE()) AS achieved,
            COUNT(*) AS total
        FROM goals
        WHERE user_id = ?
    ");
    $stmt->bind_param("i", $userId);
    $stmt->execute();
    return $stmt->get_result()->fetch_assoc();
}

function getRecentExpenses($conn, $userId) {
    $stmt = $conn->prepare("
        SELECT expense_date, expense_for, reason, amount
        FROM expenses
        WHERE user_id = ?
        ORDER BY expense_date DESC
        LIMIT 5
    ");
    $stmt->bind_param("i", $userId);
    $stmt->execute();
    return $stmt->get_result();
}

/* ==============================
   CHART DATA
================================ */

function getDailyExpenseChart($conn, $userId) {
    $range = getMonthRange();

    $stmt = $conn->prepare("
        SELECT DAY(expense_date) d, SUM(amount) total
        FROM expenses
        WHERE user_id = ?
          AND expense_date BETWEEN ? AND ?
        GROUP BY expense_date
        ORDER BY expense_date
    ");
    $stmt->bind_param("iss", $userId, $range['start'], $range['end']);
    $stmt->execute();

    $labels = [];
    $data   = [];

    foreach ($stmt->get_result() as $row) {
        $labels[] = $row['d'];
        $data[]   = (float)$row['total'];
    }

    return [$labels, $data];
}

function getCategoryPieChart($conn, $userId) {
    $range = getMonthRange();

    $stmt = $conn->prepare("
        SELECT expense_for, SUM(amount) total
        FROM expenses
        WHERE user_id = ?
          AND expense_date BETWEEN ? AND ?
        GROUP BY expense_for
    ");
    $stmt->bind_param("iss", $userId, $range['start'], $range['end']);
    $stmt->execute();

    $labels = [];
    $data   = [];

    foreach ($stmt->get_result() as $row) {
        $labels[] = $row['expense_for'];
        $data[]   = (float)$row['total'];
    }

    return [$labels, $data];
}

//Token Generation

function getUserIdFromToken($conn, $token) {
    $stmt = $conn->prepare("
        SELECT id FROM users
        WHERE api_token = ?
        LIMIT 1
    ");
    $stmt->bind_param("s", $token);
    $stmt->execute();
    return $stmt->get_result()->fetch_column();
}