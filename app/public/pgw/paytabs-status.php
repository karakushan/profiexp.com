<?php
require_once __DIR__ . '/lib/payment_helpers.php';
pay_apply_cors('GET, OPTIONS');
header('Content-Type: application/json');

function pt_cfg(): array
{
  foreach ([__DIR__ . '/config.php', dirname(__DIR__) . '/config.php', dirname(__DIR__, 2) . '/config.php'] as $p) {
    if (is_file($p)) {
      return require $p;
    }
  }

  return [
    'PAYTABS_PROFILE_ID' => getenv('PAYTABS_PROFILE_ID') ?: '',
    'PAYTABS_SERVER_KEY' => getenv('PAYTABS_SERVER_KEY') ?: '',
    'PAYTABS_BASE_URL'   => getenv('PAYTABS_BASE_URL') ?: 'https://secure.paytabs.com',
  ];
}

function pt_status_normalize(string $rawStatus): string
{
  $status = strtoupper(trim($rawStatus));

  $success = ['A', 'APPROVED', 'CAPTURED', 'SUCCESS', 'PAID'];
  $pending = ['P', 'PENDING', 'INITIATED', 'IN_PROGRESS', 'HOLD', 'ON_HOLD', 'AUTHORIZED', 'AUTHORISED'];

  if (in_array($status, $success, true)) {
    return 'SUCCESS';
  }

  if (in_array($status, $pending, true)) {
    return 'PENDING';
  }

  if ($status === '' || $status === 'UNKNOWN') {
    return 'UNKNOWN';
  }

  return 'FAILED';
}

try {
  $cfg = pt_cfg();

  $profile_id = trim((string)($cfg['PAYTABS_PROFILE_ID'] ?? ''));
  $server_key = trim((string)($cfg['PAYTABS_SERVER_KEY'] ?? ''));
  $base_url = rtrim((string)($cfg['PAYTABS_BASE_URL'] ?? 'https://secure.paytabs.com'), '/');

  if ($profile_id === '' || $server_key === '') {
    http_response_code(500);
    echo json_encode(['error' => 'PayTabs PROFILE_ID or SERVER_KEY not configured']);
    exit;
  }

  $tranRef = trim((string)($_GET['tran_ref'] ?? $_GET['tranRef'] ?? ''));
  if ($tranRef === '') {
    http_response_code(400);
    echo json_encode(['error' => 'tran_ref is required']);
    exit;
  }

  $payload = [
    'profile_id' => $profile_id,
    'tran_ref'   => $tranRef,
  ];

  $ch = curl_init($base_url . '/payment/query');
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
  $error = curl_error($ch);
  $httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  curl_close($ch);

  if ($error) {
    http_response_code(500);
    echo json_encode(['error' => $error]);
    exit;
  }

  $data = json_decode((string)$response, true);
  if (!is_array($data)) {
    http_response_code($httpCode ?: 422);
    echo json_encode(['error' => 'Invalid response from PayTabs', 'raw' => $response]);
    exit;
  }

  if (($httpCode ?: 500) >= 300) {
    http_response_code($httpCode ?: 422);
    echo json_encode(['error' => $data['message'] ?? 'PayTabs query failed', 'raw' => $data]);
    exit;
  }

  $paymentResult = $data['payment_result'] ?? [];
  if (!is_array($paymentResult)) {
    $paymentResult = [];
  }

  $rawStatus = strtoupper(trim((string)($paymentResult['response_status'] ?? $data['resp_status'] ?? $data['payment_status'] ?? 'UNKNOWN')));
  $status = pt_status_normalize($rawStatus);

  echo json_encode([
    'status' => $status,
    'raw_status' => $rawStatus,
    'tran_ref' => $tranRef,
    'payment_result' => $paymentResult,
  ]);
} catch (Throwable $e) {
  http_response_code(500);
  echo json_encode(['error' => $e->getMessage()]);
}
