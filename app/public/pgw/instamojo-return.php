<?php
// public/pgw/instamojo-return.php

// Config load (your existing smart loader)
function cfg(): array
{
  foreach ([__DIR__ . '/../../config.php', __DIR__ . '/../config.php', __DIR__ . '/config.php'] as $p) {
    if (is_file($p)) return require $p;
  }
  // Fallback to env if config missing
  return [
    'INSTAMOJO_API_KEY'    => getenv('INSTAMOJO_API_KEY')    ?: '',
    'INSTAMOJO_AUTH_TOKEN' => getenv('INSTAMOJO_AUTH_TOKEN') ?: '',
    'INSTAMOJO_SANDBOX'    => filter_var(getenv('INSTAMOJO_SANDBOX') ?: true, FILTER_VALIDATE_BOOLEAN),
  ];
}

$cfg        = cfg();
$api_key    = trim($cfg['INSTAMOJO_API_KEY']);
$auth_token = trim($cfg['INSTAMOJO_AUTH_TOKEN']);
$sandbox    = !empty($cfg['INSTAMOJO_SANDBOX']);

$payment_id         = $_GET['payment_id']         ?? '';
$payment_request_id = $_GET['payment_request_id'] ?? '';

if (!$payment_id || !$payment_request_id) {
  die('<h2 style="color:red;text-align:center;margin-top:100px;">Invalid payment data</h2>');
}

// Build API URL
$base_url = $sandbox
  ? 'https://test.instamojo.com/v2/'
  : 'https://api.instamojo.com/v2/';

$url = $base_url . "payments/{$payment_id}/";

// For local + problematic hosting/DNS
if ($sandbox) {
  $url = "https://139.59.16.17/v2/payments/{$payment_id}/";
}

$ch = curl_init($url);
curl_setopt_array($ch, [
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_TIMEOUT        => 30,
  CURLOPT_SSL_VERIFYPEER => false,
  CURLOPT_SSL_VERIFYHOST => false,
  CURLOPT_HTTPHEADER     => [
    "X-Api-Key: {$api_key}",
    "X-Auth-Token: {$auth_token}",
    "Host: " . ($sandbox ? 'test.instamojo.com' : 'api.instamojo.com')
  ],
  // Fix DNS issues on local/shared hosting
  CURLOPT_IPRESOLVE      => CURL_IPRESOLVE_V4,
]);

$response = curl_exec($ch);
$http_code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

// Default: assume failed
$success = false;
$amount  = 0;
$status  = 'Unknown';

if ($response && $http_code === 200) {
  $data    = json_decode($response, true);
  $payment = $data['payment'] ?? null;

  if ($payment && in_array($payment['status'], ['Credit', 'Completed'])) {
    $success = true;
    $amount  = $payment['amount'] ?? 0;
    $status  = $payment['status'];
  }
}
?>

<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title><?= $success ? 'Payment Success' : 'Payment Failed' ?></title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f8f9fa;
      text-align: center;
      padding: 60px 20px;
    }

    .container {
      max-width: 500px;
      margin: auto;
      background: white;
      padding: 40px;
      border-radius: 16px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
    }

    .success {
      color: #27ae60;
    }

    .failed {
      color: #e74c3c;
    }

    .icon {
      font-size: 64px;
      margin-bottom: 20px;
    }

    .big {
      font-size: 48px;
      font-weight: bold;
      margin: 10px 0;
    }

    .btn {
      display: inline-block;
      margin-top: 25px;
      padding: 14px 32px;
      background: #3498db;
      color: white;
      border-radius: 8px;
      text-decoration: none;
      font-weight: bold;
    }

    .btn:hover {
      background: #2980b9;
    }

    .info {
      background: #f0f2f5;
      padding: 15px;
      border-radius: 8px;
      margin: 20px 0;
      text-align: left;
      font-size: 14px;
    }
  </style>
</head>

<body>
  <div class="container">
    <?php if ($success): ?>
      <div class="success">
        <div class="icon">Checkmark</div>
        <div class="big">Payment Successful!</div>
        <p>Your payment has been processed successfully.</p>
      </div>
      <div class="info">
        <strong>Order ID:</strong> <?= htmlspecialchars($payment_request_id) ?><br>
        <strong>Payment ID:</strong> <?= htmlspecialchars($payment_id) ?><br>
        <strong>Amount Paid:</strong> ₹<?= number_format((float)$amount, 2) ?><br>
        <strong>Status:</strong> <?= htmlspecialchars($status) ?>
      </div>
      <a href="/" class="btn">Back to Home</a>

    <?php else: ?>
      <div class="failed">
        <div class="icon">Cross</div>
        <div class="big">Payment Failed</div>
        <p>The payment could not be processed. Please try again.</p>
      </div>
      <a href="/" class="btn">Try Again</a>
    <?php endif; ?>
  </div>
</body>

</html>
