<?php
require_once __DIR__ . '/../inc/db.php';
require_once __DIR__ . '/../inc/functions.php';

/* ===============================
   TOKEN → USER MAPPING
================================ */
$token = $_GET['token'] ?? '';

if (!$token) {
    http_response_code(403);
    die('Token missing');
}

$userId = getUserIdFromToken($conn, $token);

if (!$userId) {
    http_response_code(403);
    die('Invalid or inactive token');
}

/* ===============================
   SAVE EXPENSE
================================ */
$success = '';
$error   = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {

    $date      = $_POST['expense_date'] ?? '';
    $for       = trim($_POST['expense_for'] ?? '');
    $amount    = $_POST['amount'] ?? 0;
    $necessity = $_POST['necessity_rating'] ?? 1;
    $payment   = $_POST['payment_type'] ?? 'cash';
    $reason    = trim($_POST['reason'] ?? '');

    $onlineApp      = null;
    $onlineProvider = null;

    if ($payment === 'online') {
        $onlineApp      = $_POST['online_app'] ?? null;
        $onlineProvider = $_POST['online_provider'] ?? null;
    }

    if (!$date || !$for || !$amount) {
        $error = 'Please fill all required fields';
    } else {

        $stmt = $conn->prepare("
            INSERT INTO expenses
            (user_id, expense_date, expense_for, amount, necessity_rating,
             payment_type, online_app, online_provider, reason)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        ");

        $stmt->bind_param(
            "issdissss",
            $userId,
            $date,
            $for,
            $amount,
            $necessity,
            $payment,
            $onlineApp,
            $onlineProvider,
            $reason
        );

        if ($stmt->execute()) {
            $success = 'Expense saved successfully ✅';
        } else {
            $error = 'Something went wrong';
        }
    }
}
?>
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<title>Quick Expense Entry</title>
<meta name="viewport" content="width=device-width, initial-scale=1">

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<style>
body {
    background: #f6f7fb;
}
.quick-card {
    max-width: 720px;
    margin: 40px auto;
    border-radius: 18px;
    box-shadow: 0 20px 40px rgba(0,0,0,.08);
}
</style>
</head>

<body>

<div class="card quick-card p-4">
    <h5 class="mb-4">Add Expense</h5>

    <?php if ($success): ?>
        <div class="alert alert-success"><?= htmlspecialchars($success) ?></div>
    <?php endif; ?>

    <?php if ($error): ?>
        <div class="alert alert-danger"><?= htmlspecialchars($error) ?></div>
    <?php endif; ?>

    <form method="post">

        <div class="row g-3">

            <div class="col-md-6">
                <label class="form-label">Date</label>
                <input type="date"
                       name="expense_date"
                       max="<?= date('Y-m-d') ?>"
                       class="form-control"
                       required>
            </div>

            <div class="col-md-6">
                <label class="form-label">Expense For</label>
                <input type="text"
                       name="expense_for"
                       class="form-control"
                       required>
            </div>

            <div class="col-md-6">
                <label class="form-label">Amount</label>
                <input type="number"
                       step="0.01"
                       name="amount"
                       class="form-control"
                       required>
            </div>

            <div class="col-md-6">
                <label class="form-label">Necessity (1–5)</label>
                <select name="necessity_rating" class="form-control">
                    <option value="1">1 – Not Needed</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5 – Essential</option>
                </select>
            </div>

            <div class="col-md-6">
                <label class="form-label">Payment Type</label>
                <select name="payment_type"
                        id="payment_type"
                        class="form-control">
                    <option value="cash">Cash</option>
                    <option value="online">Online</option>
                </select>
            </div>

            <div class="col-md-6" id="onlineWrap" style="display:none">
                <label class="form-label">Online Mode</label>
                <select name="online_app" id="online_app" class="form-control">
                    <option value="">Select</option>
                    <option value="upi">UPI</option>
                    <option value="card">Card</option>
                    <option value="banking">Net Banking</option>
                </select>
            </div>

            <div class="col-md-6" id="providerWrap" style="display:none">
                <label class="form-label" id="providerLabel">Provider</label>
                <select name="online_provider" id="online_provider" class="form-control">
                    <!-- dynamically filled -->
                </select>
            </div>

            <div class="col-12">
                <label class="form-label">Reason</label>
                <textarea name="reason" class="form-control" rows="3"></textarea>
            </div>

        </div>

        <div class="d-flex justify-content-end gap-2 mt-4">
            <button type="reset" class="btn btn-secondary">Cancel</button>
            <button class="btn btn-primary">Save Expense</button>
        </div>

    </form>
</div>

<script>
document.getElementById('payment_type').addEventListener('change', function () {
    document.getElementById('onlineWrap').style.display =
        this.value === 'online' ? 'block' : 'none';
});
</script>

<script>
const paymentType   = document.getElementById('payment_type');
const onlineWrap    = document.getElementById('onlineWrap');
const providerWrap  = document.getElementById('providerWrap');
const onlineApp     = document.getElementById('online_app');
const provider      = document.getElementById('online_provider');
const providerLabel = document.getElementById('providerLabel');

const options = {
    upi: [
        'PhonePe',
        'Google Pay',
        'Paytm',
        'BHIM',
        'Amazon Pay'
    ],
    card: [
        'HDFC Bank',
        'ICICI Bank',
        'SBI',
        'Axis Bank',
        'Kotak'
    ],
    banking: [
        'HDFC Bank',
        'ICICI Bank',
        'SBI',
        'Axis Bank',
        'Kotak'
    ]
};

paymentType.addEventListener('change', () => {
    if (paymentType.value === 'online') {
        onlineWrap.style.display   = 'block';
        providerWrap.style.display = 'none';
    } else {
        onlineWrap.style.display   = 'none';
        providerWrap.style.display = 'none';
    }
});

onlineApp.addEventListener('change', () => {
    const type = onlineApp.value;

    provider.innerHTML = '<option value="">Select</option>';

    if (!type || !options[type]) {
        providerWrap.style.display = 'none';
        return;
    }

    options[type].forEach(item => {
        const opt = document.createElement('option');
        opt.value = item;
        opt.textContent = item;
        provider.appendChild(opt);
    });

    providerLabel.textContent =
        type === 'upi' ? 'UPI App'
      : type === 'card' ? 'Card Type'
      : 'Bank Name';

    providerWrap.style.display = 'block';
});
</script>

</body>
</html>