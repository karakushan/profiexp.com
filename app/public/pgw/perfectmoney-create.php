<?php
header('Content-Type: application/json');

function pm_cfg(): array
{
  foreach ([__DIR__ . '/config.php', dirname(__DIR__) . '/config.php'] as $p) {
    if (is_file($p)) return require $p;
  }
  return [
    'PM_WALLET'          => getenv('PM_WALLET') ?: 'U45424907',           // আপনার Wallet ID
    'PM_PASS'            => getenv('PM_PASS') ?: '',                     // Alternate Passphrase (অবশ্যই লাগবে)
    'PM_NAME'            => getenv('PM_NAME') ?: 'My Store',
    'PUBLIC_API_BASE'    => getenv('PUBLIC_API_BASE') ?: '',
  ];
}

try {
  $cfg = pm_cfg();
  $wallet   = trim($cfg['PM_WALLET']);
  $pass     = trim($cfg['PM_PASS']);
  $name     = $cfg['PM_NAME'];
  $base     = rtrim($cfg['PUBLIC_API_BASE'], '/');

  if (!$pass) {
    http_response_code(500);
    echo json_encode(['error' => 'Alternate Passphrase missing']);
    exit;
  }

  $in = json_decode(file_get_contents('php://input') ?: '[]', true) ?: [];
  $amount = round((float)($in['amount'] ?? 0), 2);
  $order_id = $in['order_id'] ?? 'PM-' . date('YmdHis');

  if ($amount < 0.01) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid amount']);
    exit;
  }

  $params = [
    'PAYEE_ACCOUNT'   => $wallet,
    'PAYEE_NAME'      => $name,
    'PAYMENT_AMOUNT'  => number_format($amount, 2, '.', ''),
    'PAYMENT_UNITS'   => 'USD',
    'PAYMENT_ID'      => $order_id,
    'STATUS_URL'      => $base . '/perfectmoney-ipn.php',
    'PAYMENT_URL'     => $base . '/perfectmoney-success.php',
    'NOPAYMENT_URL'   => $base . '/perfectmoney-fail.php',
    'BAGGAGE_FIELDS'  => 'order_id name email',
    'order_id'        => $order_id,
    'name'            => $in['name'] ?? 'Customer',
    'email'           => $in['email'] ?? '',
    'SUGGESTED_MEMO'  => $in['description'] ?? 'Payment',
  ];

  $url = 'https://perfectmoney.com/api/step1.asp?' . http_build_query($params);

  echo json_encode([
    'order_id'    => $order_id,
    'amount'      => $amount,
    'payment_url' => $url
  ]);
} catch (Throwable $e) {
  http_response_code(500);
  echo json_encode(['error' => 'Server error']);
}
