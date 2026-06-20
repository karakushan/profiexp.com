<?php
// yoco-create.php → Production Ready (2025)
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');                    // Flutter এর জন্য (পরে ডোমেইন সেট করো)
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

// শুধু POST ছাড়া কিছু চলবে না
if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  http_response_code(405);
  echo json_encode(['error' => 'Method Not Allowed. Use POST']);
  exit;
}

// JSON ইনপুট পড়া
$input = json_decode(file_get_contents('php://input'), true);
if (json_last_error() !== JSON_ERROR_NONE || !$input) {
  http_response_code(400);
  echo json_encode(['error' => 'Invalid JSON']);
  exit;
}


function tp_cfg(): array
{
  foreach ([__DIR__ . '/config.php', dirname(__DIR__) . '/config.php', dirname(__DIR__, 2) . '/config.php'] as $p) {
    if (is_file($p)) return require $p;
  }
  return [
    'YOCO_SECRET_KEY'          => getenv('YOCO_SECRET_KEY'),
    'PUBLIC_API_BASE'   => getenv('PUBLIC_API_BASE') ?: '',
  ];
}

$cfg  = tp_cfg();
$YOCO_SECRET_KEY  = trim((string)$cfg['YOCO_SECRET_KEY']);
$retBase = rtrim((string)($cfg['PUBLIC_API_BASE'] ?: $local), '/');

// ====== তোমার Yoco Secret Key (অবশ্যই এখানে বসাও) ======
// $YOCO_SECRET_KEY = 'sk_test_960bfde0VBrLlpK098e4ffeb53e1';
// অথবা টেস্ট করার সময়: sk_test_XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

if (empty($YOCO_SECRET_KEY) || strlen($YOCO_SECRET_KEY) < 20) {
  http_response_code(500);
  echo json_encode(['error' => 'YOCO_SECRET_KEY not set']);
  exit;
}

// ====== ইনপুট ======
$amountCents = (int)($input['amount_cents'] ?? 0);
$customerName = trim($input['name'] ?? 'Customer');
$customerEmail = trim($input['email'] ?? '');
$description = trim($input['description'] ?? 'Payment');

// ভ্যালিডেশন
if ($amountCents < 100) {
  http_response_code(400);
  echo json_encode(['error' => 'Minimum amount is R1.00 (100 cents)']);
  exit;
}

// ইউনিক অর্ডার আইডি (খুবই জরুরি)
$orderId = 'order_' . time() . '_' . bin2hex(random_bytes(5));

// ====== Yoco API পেলোড ======
$payload = [
  "amount"              => $amountCents,
  "currency"            => "ZAR",
  "description"         => $description,
  "metadata"            => [
    "order_id"        => $orderId,
    "customer_name"   => $customerName,
    "customer_email"  => $customerEmail,
  ],
  "successRedirectUrl" => $retBase . "/yoco-success.php?order=$orderId",
  "failureRedirectUrl" => $retBase . "/yoco-failed.php?order=$orderId",
  "cancelRedirectUrl"  => $retBase . "/yoco-cancelled.php?order=$orderId",
];

// ====== cURL দিয়ে Yoco কে কল ======
$ch = curl_init('https://payments.yoco.com/api/checkouts');
curl_setopt_array($ch, [
  CURLOPT_POST           => true,
  CURLOPT_HTTPHEADER     => [
    'Authorization: Bearer ' . $YOCO_SECRET_KEY,
    'Content-Type: application/json',
    'Idempotency-Key: ' . $orderId,
  ],
  CURLOPT_POSTFIELDS     => json_encode($payload, JSON_UNESCAPED_SLASHES),
  CURLOPT_RETURNTRANSFER => true,
  CURLOPT_TIMEOUT        => 45,
  CURLOPT_SSL_VERIFYPEER => true,
]);

$response   = curl_exec($ch);
$httpCode   = curl_getinfo($ch, CURLINFO_HTTP_CODE);
$curlError  = curl_error($ch);
curl_close($ch);

// ====== এরর হ্যান্ডলিং (প্রোডাকশনে এটা রাখো) ======
if ($curlError) {
  http_response_code(500);
  echo json_encode(['error' => 'Network error', 'details' => $curlError]);
  exit;
}

$data = json_decode($response, true);


// নতুন (সঠিক) – এটা বসাও
if ($httpCode < 200 || $httpCode >= 300 || empty($data['id']) || empty($data['redirectUrl'])) {
  http_response_code(400);
  echo json_encode([
    'error'         => 'Yoco API Error',
    'http_code'     => $httpCode,
    'yoco_message'  => $data['error']['message'] ?? 'Failed to create checkout',
    'full_response' => $data
  ], JSON_PRETTY_PRINT);
  exit;
}

// ====== সফল হলে এটাই ফেরত দিবে Flutter এ ======
echo json_encode([
  'success'       => true,
  'payment_id'    => $data['id'],
  'redirect_url'  => $data['redirectUrl'],
  'order_id'      => $orderId,
  'status'        => $data['status'],
  'amount_cents'  => $amountCents,
], JSON_PRETTY_PRINT);
