<?php
// NOWPayments callback handler for app checkout flow.
// - GET: redirects mobile WebView back to the app deep link.
// - POST: accepts IPN callbacks with a lightweight JSON response.

if (strtoupper($_SERVER['REQUEST_METHOD'] ?? 'GET') === 'POST') {
  header('Content-Type: application/json');
  echo json_encode(['ok' => true]);
  exit;
}

$invoiceId = trim((string)($_GET['invoice_id'] ?? $_GET['id'] ?? ''));
$status = trim((string)($_GET['status'] ?? $_GET['payment_status'] ?? ''));

if ($status === '' && isset($_GET['success'])) {
  $status = 'SUCCESS';
}

if ($status === '' && isset($_GET['cancel'])) {
  $status = 'CANCELED';
}

$schemeUrl = 'myapp://nowpayments-finish';
$params = [];

if ($invoiceId !== '') {
  $params['invoice_id'] = $invoiceId;
}

if ($status !== '') {
  $params['status'] = strtoupper($status);
}

if (!empty($params)) {
  $schemeUrl .= '?' . http_build_query($params);
}

header('Content-Type: text/html; charset=utf-8');
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Returning to App</title>
</head>
<body>
  <script>location.replace('<?= htmlspecialchars($schemeUrl, ENT_QUOTES) ?>');</script>
  <noscript><a href="<?= htmlspecialchars($schemeUrl, ENT_QUOTES) ?>">Return to app</a></noscript>
</body>
</html>
