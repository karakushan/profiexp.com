<?php
require_once __DIR__ . '/lib/payment_helpers.php';
pay_apply_cors('POST, OPTIONS');
header('Content-Type: application/json');

/**
 * Input JSON example:
 * {
 *   "amount": 150.00,
 *   "name": "Ahmad Ali",
 *   "email": "ahmad@example.com",
 *   "phone": "0100000000",
 *   "description": "Order #12345",
 *   "order_id": "ORD-2025-0001"   // optional
 * }
 *
 * Output on success:
 * { "tran_ref": "TST2234500012345", "redirect_url": "https://secure.paytabs.com/payment/page/XXXXXXXXXXXXXXXX" }
 */

function pt_cfg(): array
{
  foreach ([__DIR__ . '/config.php', dirname(__DIR__) . '/config.php', dirname(__DIR__, 2) . '/config.php'] as $p) {
    if (is_file($p)) return require $p;
  }
  return [
    'PAYTABS_PROFILE_ID' => getenv('PAYTABS_PROFILE_ID') ?: '',
    'PAYTABS_SERVER_KEY' => getenv('PAYTABS_SERVER_KEY') ?: '',
    'PAYTABS_BASE_URL'   => getenv('PAYTABS_BASE_URL') ?: 'https://secure.paytabs.com',
    'PUBLIC_API_BASE'    => getenv('PUBLIC_API_BASE') ?: '',
  ];
}

function pt_log($msg)
{
  @file_put_contents(sys_get_temp_dir() . '/paytabs_create.log', '[' . date('Y-m-d H:i:s') . "] $msg\n", FILE_APPEND);
}

try {
  $cfg = pt_cfg();

  $profile_id  = trim($cfg['PAYTABS_PROFILE_ID']);
  $server_key  = trim($cfg['PAYTABS_SERVER_KEY']);
  $base_url    = rtrim($cfg['PAYTABS_BASE_URL'], '/');

  if (!$profile_id || !$server_key) {
    http_response_code(500);
    echo json_encode(['error' => 'PayTabs PROFILE_ID or SERVER_KEY not configured']);
    exit;
  }

  $input = json_decode(file_get_contents('php://input') ?: '[]', true) ?: [];

  $amount      = round((float)($input['amount'] ?? 0), 2);
  $currency    = strtoupper(trim((string)($input['currency'] ?? 'MYR')));
  $name        = trim($input['name'] ?? 'Customer');
  $email       = trim($input['email'] ?? '');
  $phone       = trim($input['phone'] ?? '');
  $description = trim($input['description'] ?? 'Payment');
  $return_base = trim((string)($input['return_base'] ?? ''));
  $order_id    = trim($input['order_id'] ?? 'ORD-' . date('YmdHis') . '-' . substr(bin2hex(random_bytes(4)), 0, 8));

  if (!preg_match('/^[A-Z]{3}$/', $currency)) {
    $currency = 'MYR';
  }

  if ($amount <= 0) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid or missing amount']);
    exit;
  }

  // Public callback URLs
  $is_https = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') || ($_SERVER['SERVER_PORT'] ?? 0) == 443;
  $scheme   = $is_https ? 'https' : 'http';
  $local    = $scheme . '://' . ($_SERVER['HTTP_HOST'] ?? 'localhost') . dirname($_SERVER['REQUEST_URI']);
  $public   = $return_base !== ''
    ? rtrim($return_base, '/')
    : rtrim($cfg['PUBLIC_API_BASE'] ?: $local, '/');

  $payload = [
    "profile_id"      => $profile_id,
    "tran_type"       => "sale",
    "tran_class"      => "ecom",
    "cart_id"         => $order_id,
    "cart_description" => $description,
    "cart_currency"   => $currency,
    "cart_amount"     => number_format($amount, 2, '.', ''),
    "customer_details" => [
      "name"        => $name,
      "email"       => $email,
      "phone"       => $phone,
      "street1"     => "Address line 1",
      "city"        => "Kuala Lumpur",
      "state"       => "WP",
      "country"     => "MY",
      "zip"         => "50000"
    ],
    "return"          => $public . '/paytabs-return.php',    // success page
    "callback"        => $public . '/paytabs-callback.php',   // server-to-server
    "hide_shipping"   => true,
  ];

  $ch = curl_init($base_url . '/payment/request');
  curl_setopt_array($ch, [
    CURLOPT_POST           => true,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_HTTPHEADER     => [
      'Authorization: Bearer ' . $server_key,
      'Content-Type: application/json',
    ],
    CURLOPT_POSTFIELDS     => json_encode($payload),
    CURLOPT_TIMEOUT        => 45,
    CURLOPT_SSL_VERIFYPEER => true,
  ]);

  $response = curl_exec($ch);
  $err      = curl_error($ch);
  $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  curl_close($ch);

  pt_log("=== PAYTABS DEBUG START ===");
  pt_log("HTTP Code: $httpCode");
  pt_log("cURL Error: " . ($err ?: 'No error'));
  pt_log("Raw Response: " . substr($response, 0, 1000));  
  pt_log("=== PAYTABS DEBUG END ===");


  if ($err) {
    pt_log("cURL Error: $err");
    http_response_code(500);
    echo json_encode(['error' => 'Payment gateway error']);
    exit;
  }

  $data = json_decode($response, true);

  if ($httpCode !== 200 || empty($data['redirect_url'])) {
    pt_log("PayTabs error response: " . $response);
    http_response_code(422);
    echo json_encode([
      'error' => $data['message'] ?? 'Failed to create payment page',
      'raw'   => $data
    ]);
    exit;
  }

  echo json_encode([
    'tran_ref'      => $data['tran_ref'] ?? '',
    'redirect_url'  => $data['redirect_url'],
    'order_id'      => $order_id,
  ]);
} catch (Throwable $e) {
  pt_log('Exception: ' . $e->getMessage() . ' | ' . $e->getTraceAsString());
  http_response_code(500);
  echo json_encode(['error' => 'Server error']);
}
