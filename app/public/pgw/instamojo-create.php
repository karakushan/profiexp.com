<?php
header('Content-Type: application/json');

/**
 * Instamojo Payment Request Create (v2 API)
 * Returns: {"payment_request_id":"...", "longurl":"https://..."}
 */

function cfg(): array
{
  foreach ([__DIR__ . '/config.php', dirname(__DIR__) . '/config.php', dirname(__DIR__, 2) . '/config.php'] as $p) {
    if (is_file($p)) return require $p;
  }
  return [
    'INSTAMOJO_API_KEY'    => getenv('INSTAMOJO_API_KEY')    ?: '',
    'INSTAMOJO_AUTH_TOKEN' => getenv('INSTAMOJO_AUTH_TOKEN') ?: '',
    'INSTAMOJO_SANDBOX'    => getenv('INSTAMOJO_SANDBOX') === 'true', // true = sandbox
    'PUBLIC_API_BASE'      => getenv('PUBLIC_API_BASE')       ?: '',
  ];
}

function log_pp($m)
{
  @file_put_contents(sys_get_temp_dir() . '/instamojo_create.log', '[' . date('Y-m-d H:i:s') . "] $m\n", FILE_APPEND);
}

try {
  $cfg = cfg();

  $api_key    = trim($cfg['INSTAMOJO_API_KEY']);
  $auth_token = trim($cfg['INSTAMOJO_AUTH_TOKEN']);
  $sandbox    = !empty($cfg['INSTAMOJO_SANDBOX']);

  if (!$api_key || !$auth_token) {
    http_response_code(500);
    echo json_encode(['error' => 'Instamojo API_KEY / AUTH_TOKEN missing']);
    exit;
  }

  $base_url = $sandbox
    ? 'https://test.instamojo.com/v2/'      // correct sandbox
    : 'https://api.instamojo.com/v2/';      // correct production

  $in = json_decode(file_get_contents('php://input') ?: '[]', true) ?: [];

  $amount      = round((float)($in['amount_minor'] ?? 0) / 100, 2); 
  $purpose     = trim($in['description'] ?? 'Order Payment');
  $buyer_name  = trim($in['name'] ?? 'Customer');
  $email       = trim($in['email'] ?? '');
  $phone       = preg_replace('~[^0-9]~', '', $in['mobile'] ?? '');
  $muid        = $in['merchant_user_id'] ?? 'user_' . bin2hex(random_bytes(4));

  if ($amount <= 0) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid amount']);
    exit;
  }

  // Return / Webhook URLs
  $https   = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') || ($_SERVER['SERVER_PORT'] ?? 0) == 443;
  $scheme  = $https ? 'https' : 'http';
  $local   = rtrim($scheme . '://' . $_SERVER['HTTP_HOST'] . dirname($_SERVER['REQUEST_URI']), '/');
  $retBase = rtrim($cfg['PUBLIC_API_BASE'] ?: $local, '/');

  $redirect_url = $retBase . '/instamojo-return.php';   
  $webhook_url  = $retBase . '/instamojo-webhook.php';  

  // Instamojo Payment Request Payload
  $data = [
    'amount'         => $amount,           // decimal, like 100.00
    'purpose'        => $purpose,
    'buyer_name'     => $buyer_name,
    'email'          => $email ?: null,
    'phone'          => $phone ?: null,
    'redirect_url'   => $redirect_url,
    'webhook'        => $webhook_url,
    'send_email'     => false,
    'send_sms'       => false,
    'allow_repeated_payments' => false,
  ];

  // Remove null values
  $data = array_filter($data, fn($v) => $v !== null);

  $ch = curl_init($base_url . 'payment_requests/');
  curl_setopt_array($ch, [
    CURLOPT_POST           => true,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_HTTPHEADER     => [
      'X-Api-Key: ' . $api_key,
      'X-Auth-Token: ' . $auth_token,
      'Content-Type: application/json',
    ],
    CURLOPT_POSTFIELDS     => json_encode($data),
    CURLOPT_TIMEOUT        => 45,
  ]);

  $response = curl_exec($ch);
  $err      = curl_error($ch);
  $code     = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  curl_close($ch);

  if ($err) {
    log_pp("cURL Error: $err");
    http_response_code(500);
    echo json_encode(['error' => 'Network error']);
    exit;
  }

  $res = json_decode($response, true);

  if ($code >= 300 || empty($res['success'])) {
    log_pp("Instamojo API Error: $code - " . json_encode($res));
    http_response_code($code ?: 422);
    echo json_encode([
      'error'   => $res['message'] ?? 'INSTAMOJO_ERROR',
      'details' => $res
    ]);
    exit;
  }

  $payment_request = $res['payment_request'];

  echo json_encode([
    'merchant_txn_id'     => $payment_request['id'],           // Instamojo Payment Request ID
    'redirect_url'        => $payment_request['longurl'],      
    'payment_request_id'  => $payment_request['id'],
    'status'              => $payment_request['status'],
  ]);
} catch (Throwable $e) {
  log_pp('Exception: ' . $e->getMessage() . "\n" . $e->getTraceAsString());
  http_response_code(500);
  echo json_encode(['error' => 'Server error']);
}
