<?php
require_once __DIR__ . '/lib/payment_helpers.php';
pay_apply_cors('POST, OPTIONS');
header('Content-Type: application/json');

/**
 * Creates a Flutterwave Hosted Checkout and returns:
 *   {"tx_ref":"ref_...","redirect_url":"https://checkout.flutterwave.com/v3/hosted/pay/..."}
 *
 * Reads JSON body from client:
 *   {
 *     "amount_minor": 2599,
 *     "currency": "USD",
 *     "name": "Demo",
 *     "email": "demo@example.com",
 *     "description": "Order",
 *     "return_base": "http://192.168.0.187:8181/pgw"
 *   }
 */

function fw_log($msg) {
  @file_put_contents(sys_get_temp_dir().'/flutterwave_create.log',
    '['.date('Y-m-d H:i:s')."] $msg\n", FILE_APPEND);
}

// Load config (file or env fallback)
function load_cfg(): array {
  foreach ([__DIR__.'/config.php', dirname(__DIR__).'/config.php', dirname(__DIR__,2).'/config.php'] as $p) {
    if (is_file($p)) return require $p;
  }
  return [
    'FLW_SECRET_KEY'  => getenv('FLW_SECRET_KEY') ?: '',
    'FLW_BASE'        => getenv('FLW_BASE') ?: 'https://api.flutterwave.com',
    'PUBLIC_API_BASE' => getenv('PUBLIC_API_BASE') ?: '',
    'FLW_SSL_VERIFY' => getenv('FLW_SSL_VERIFY') !== false
      ? filter_var(getenv('FLW_SSL_VERIFY'), FILTER_VALIDATE_BOOLEAN)
      : true,
    'FLW_CURL_CA_BUNDLE' => getenv('FLW_CURL_CA_BUNDLE') ?: '',
  ];
}

function fw_apply_ssl_options(array $cfg, array &$opts): void {
  $verify = $cfg['FLW_SSL_VERIFY'] ?? true;

  if (is_string($verify)) {
    $verify = !in_array(strtolower(trim($verify)), ['0', 'false', 'off', 'no'], true);
  }

  $verify = (bool) $verify;

  $opts[CURLOPT_SSL_VERIFYPEER] = $verify;
  $opts[CURLOPT_SSL_VERIFYHOST] = $verify ? 2 : 0;

  $caBundle = trim((string)($cfg['FLW_CURL_CA_BUNDLE'] ?? ''));
  if ($verify && $caBundle !== '' && is_file($caBundle)) {
    $opts[CURLOPT_CAINFO] = $caBundle;
  }
}

try {
  $cfg  = load_cfg();
  $base = rtrim((string)($cfg['FLW_BASE'] ?? 'https://api.flutterwave.com'), '/');
  $key  = trim((string)($cfg['FLW_SECRET_KEY'] ?? ''));

  if ($key === '') {
    http_response_code(500);
    echo json_encode(['error' => 'FLW_SECRET_KEY missing (add to config.php)']);
    exit;
  }

  // Read request
  $raw = file_get_contents('php://input') ?: '';
  $in  = json_decode($raw, true) ?: [];

  $amountMinor = (int)($in['amount_minor'] ?? 0);
  $currency    = strtoupper((string)($in['currency'] ?? 'USD')); // supports many: USD, NGN, KES, ZAR, etc.
  $name        = trim((string)($in['name'] ?? 'Customer'));
  $email       = trim((string)($in['email'] ?? 'customer@example.com'));
  $desc        = trim((string)($in['description'] ?? 'Order'));

  if ($amountMinor <= 0) {
    http_response_code(400);
    echo json_encode(['error' => 'Invalid amount_minor']);
    exit;
  }

  // Flutterwave expects decimal amount (not minor units)
  $amount = (float) number_format($amountMinor/100, 2, '.', '');

  // Build redirect URL.
  // Prefer app-provided return_base (reachable by device), then use matching configured base, else local request base.
  $https  = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') || (($_SERVER['SERVER_PORT'] ?? null) == 443);
  $scheme = $https ? 'https' : 'http';
  $localBase = rtrim($scheme.'://'.$_SERVER['HTTP_HOST'].dirname($_SERVER['REQUEST_URI']), '/');

  $retBase = $localBase;
  $inputReturnBase = trim((string)($in['return_base'] ?? ''));
  if ($inputReturnBase !== '' && filter_var($inputReturnBase, FILTER_VALIDATE_URL)) {
    $retBase = rtrim($inputReturnBase, '/');
  } else {
    $configuredBase = trim((string)($cfg['PUBLIC_API_BASE'] ?? ''));
    if ($configuredBase !== '' && filter_var($configuredBase, FILTER_VALIDATE_URL)) {
      $configuredHost = strtolower((string)(parse_url($configuredBase, PHP_URL_HOST) ?: ''));
      $requestHost = strtolower((string)($_SERVER['HTTP_HOST'] ?? ''));
      if (strpos($requestHost, ':') !== false) {
        $requestHost = explode(':', $requestHost, 2)[0];
      }

      if ($configuredHost !== '' && $requestHost !== '' && $configuredHost === $requestHost) {
        $retBase = rtrim($configuredBase, '/');
      }
    }
  }

  $redirectUrl = $retBase . '/flutterwave-return.php';

  // Unique reference for this payment
  $txRef = 'fw_' . date('YmdHis') . '_' . bin2hex(random_bytes(4));

  // Create hosted payment
  $url = $base . '/v3/payments';
  $payload = [
    'tx_ref'       => $txRef,
    'amount'       => $amount,
    'currency'     => $currency,
    'redirect_url' => $redirectUrl,
    'customer'     => [
      'email' => $email,
      'name'  => $name,
    ],
    'customizations' => [
      'title'       => 'Checkout',
      'description' => $desc,
    ],
  ];

  $ch = curl_init($url);
  $opts = [
    CURLOPT_POST           => true,
    CURLOPT_HTTPHEADER     => [
      'Authorization: Bearer ' . $key,
      'Content-Type: application/json',
    ],
    CURLOPT_POSTFIELDS     => json_encode($payload),
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_TIMEOUT        => 45,
  ];
  fw_apply_ssl_options($cfg, $opts);
  curl_setopt_array($ch, $opts);
  $resBody = curl_exec($ch);
  $curlErr = curl_error($ch);
  $code    = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  curl_close($ch);

  if ($curlErr) {
    fw_log("curl error: $curlErr");
    http_response_code(500);
    echo json_encode(['error' => $curlErr]);
    exit;
  }

  $res = json_decode($resBody, true);
  if (!is_array($res)) {
    fw_log("non-json ($code): $resBody");
    http_response_code($code ?: 500);
    echo json_encode(['error' => 'Non-JSON response', 'raw' => $resBody]);
    exit;
  }

  if ($code >= 300 || empty($res['status']) || $res['status'] !== 'success') {
    fw_log("api error ($code): ".json_encode($res));
    http_response_code($code ?: 422);
    echo json_encode([
      'error' => $res['message'] ?? 'Flutterwave error',
      'raw'   => $res,
      'sent'  => $payload,
    ]);
    exit;
  }

  $link = $res['data']['link'] ?? null;
  if (!$link) {
    http_response_code(500);
    echo json_encode(['error' => 'Missing hosted link', 'raw' => $res]);
    exit;
  }

  echo json_encode([
    'tx_ref'       => $txRef,
    'redirect_url' => $link,
  ]);
} catch (Throwable $e) {
  fw_log('exception: '.$e->getMessage());
  http_response_code(500);
  echo json_encode(['error' => $e->getMessage()]);
}
