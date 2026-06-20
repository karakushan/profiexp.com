<?php

header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
header('Access-Control-Allow-Methods: POST, OPTIONS');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') exit;
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  die(json_encode(['error' => 'Only POST method allowed']));
}

$input = json_decode(file_get_contents('php://input'), true);
if (!$input || !isset($input['amount_try']) || !is_numeric($input['amount_try'])) {
  die(json_encode(['error' => 'amount_try is required and valid number required']));
}

// ========================
// Config Load (config.php or .env)
// ========================
function loadConfig(): array
{
  $paths = [__DIR__ . '/config.php', dirname(__DIR__) . '/config.php', dirname(__DIR__, 2) . '/config.php'];
  foreach ($paths as $path) {
    if (is_file($path)) return require $path;
  }

  return [
    'IYZICO_API_KEY'     => getenv('IYZICO_API_KEY')     ?: '',
    'IYZICO_SECRET_KEY'  => getenv('IYZICO_SECRET_KEY')  ?: '',
    'IYZICO_MODE'        => getenv('IYZICO_MODE')        ?: '1', // 1 = sandbox, 0 = live
    'PUBLIC_BASE_URL'    => getenv('PUBLIC_BASE_URL')    ?: '',
  ];
}

$config    = loadConfig();
$apiKey    = trim($config['IYZICO_API_KEY']);
$secretKey = ($config['IYZICO_SECRET_KEY']);
$mode      = (int)$config['IYZICO_MODE'];

if (empty($apiKey) || empty($secretKey)) {
  die(json_encode(['error' => 'Iyzico credentials not configured']));
}

$baseUrl = $mode === 1
  ? 'https://sandbox-api.iyzipay.com'
  : 'https://api.iyzipay.com';

// ========================
// Public Base URL (callback এর জন্য)
// ========================
$publicBase = trim($config['PUBLIC_BASE_URL'] ?? '');
if (empty($publicBase)) {
  $protocol = (!empty($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off') || $_SERVER['SERVER_PORT'] == 443 ? 'https' : 'http';
  $publicBase = $protocol . '://' . ($_SERVER['HTTP_HOST'] ?? 'localhost');
}
$publicBase = rtrim($publicBase, '/');

// ========================
// Input Data
// ========================
$amount = number_format((float)$input['amount_try'], 2, '.', '');

$buyerName     = trim($input['buyer_name'] ?? 'Müşteri');
$buyerSurname  = trim($input['buyer_surname'] ?? 'Soyadı');
$buyerEmail    = filter_var($input['buyer_email'] ?? 'test@iyzico.com', FILTER_VALIDATE_EMAIL) ?: 'test@iyzico.com';
$buyerPhone    = preg_replace('/\D/', '', $input['buyer_phone'] ?? '905350000000');
if (strlen($buyerPhone) === 10) $buyerPhone = '90' . $buyerPhone;
if (strlen($buyerPhone) === 11 && substr($buyerPhone, 0, 1) === '0') $buyerPhone = '9' . substr($buyerPhone, 1);
$buyerPhone    = '+' . $buyerPhone;

$buyerIdentity = preg_replace('/\D/', '', $input['buyer_identity'] ?? '11111111111');
if (strlen($buyerIdentity) !== 11) $buyerIdentity = '11111111111';

$orderId = 'ORD-' . time() . '-' . rand(1000, 9999);

// ========================
// iyzico Request Payload
// ========================
$request = [
  "locale"         => "tr",
  "conversationId" => $orderId,
  "price"          => $amount,
  "paidPrice"      => $amount,
  "currency"       => "TRY",
  "installment"    => 1,
  "basketId"       => $orderId,
  "paymentGroup"   => "PRODUCT",
  "callbackUrl"    => $publicBase . "/iyzico-callback.php?order=" . $orderId,
  "buyer" => [
    "id"                  => "BY" . substr(time(), -6),
    "name"                => $buyerName,
    "surname"             => $buyerSurname,
    "gsmNumber"           => $buyerPhone,
    "email"               => $buyerEmail,
    "identityNumber"      => $buyerIdentity,
    "registrationAddress" => "Nidakule Göztepe, Merdivenköy Mah.",
    "city"                => "Istanbul",
    "country"             => "Turkey"
  ],
  "shippingAddress" => [
    "contactName" => "$buyerName $buyerSurname",
    "city"        => "Istanbul",
    "country"     => "Turkey",
    "address"     => "Kadıköy"
  ],
  "billingAddress" => [
    "contactName" => "$buyerName $buyerSurname",
    "city"        => "Istanbul",
    "country"     => "Turkey",
    "address"     => "Kadıköy"
  ],
  "basketItems" => [[
    "id"        => "ITEM001",
    "name"      => "Ödeme",
    "category1" => "Genel",
    "itemType"  => "VIRTUAL",
    "price"     => $amount
  ]]
];

$jsonBody     = json_encode($request, JSON_UNESCAPED_SLASHES | JSON_UNESCAPED_UNICODE);
$randomString = bin2hex(random_bytes(16));

// ========================
// Iyzico v2 Authentication
// ========================
$hashString   = $apiKey . $randomString . $secretKey . $jsonBody;
$sha256Hash   = hash('sha256', $hashString, true);
$authorization = 'IYZWSv2 ' . base64_encode($apiKey . ':' . $sha256Hash);

$headers = [
  'Authorization: ' . $authorization,
  'x-iyzi-rnd: ' . $randomString,
  'x-iyzi-client-version: 2.0',
  'Content-Type: application/json'
];

// ========================
// Send Request
// ========================
$ch = curl_init();
curl_setopt_array($ch, [
  CURLOPT_URL            => $baseUrl . '/v2/checkoutform/initialize',
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_POST           => true,
  CURLOPT_POSTFIELDS     => $jsonBody,
  CURLOPT_HTTPHEADER     => $headers,
  CURLOPT_TIMEOUT        => 60,
  CURLOPT_SSL_VERIFYPEER => true
]);

$response = curl_exec($ch);
$httpCode = curl_getinfo($ch, CURLINFO_HTTP_CODE);
curl_close($ch);

$result = json_decode($response, true);

if ($httpCode !== 200 || ($result['status'] ?? '') !== 'success') {
  echo json_encode([
    'success' => false,
    'error'   => $result['errorMessage'] ?? 'Iyzico bağlantı hatası',
    'code'    => $result['errorCode'] ?? $httpCode,
    'debug'   => $mode === 1 ? ['rnd' => $randomString] : null
  ]);
  exit;
}

echo json_encode([
  'success'          => true,
  'token'            => $result['token'],
  'payment_page_url' => $result['checkoutFormContent'], 
  'order_id'         => $orderId
]);
