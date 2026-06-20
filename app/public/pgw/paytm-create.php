<?php
// paytm-create.php → Production Ready (2025)
header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');        // Flutter/Web এর জন্য
header('Access-Control-Allow-Methods: POST');
header('Access-Control-Allow-Headers: Content-Type');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
  http_response_code(405);
  echo json_encode(['error' => 'Method Not Allowed. Use POST']);
  exit;
}

$input = json_decode(file_get_contents('php://input'), true);
if (json_last_error() !== JSON_ERROR_NONE || !$input) {
  http_response_code(400);
  echo json_encode(['error' => 'Invalid JSON']);
  exit;
}

// ====== Config লোড করা ======
function pt_cfg(): array
{
  foreach ([__DIR__ . '/config.php', dirname(__DIR__) . '/config.php'] as $p) {
    if (is_file($p)) return require $p;
  }
  return [
    'PAYTM_MERCHANT_ID'   => getenv('PAYTM_MERCHANT_ID') ?: '',
    'PAYTM_MERCHANT_KEY'  => getenv('PAYTM_MERCHANT_KEY') ?: '',
    'PAYTM_WEBSITE'       => getenv('PAYTM_WEBSITE') ?: 'WEBSTAGING', // অথবা DEFAULT
    'PAYTM_ENV'           => getenv('PAYTM_ENV') ?: 'test',           // test / prod
    'PUBLIC_API_BASE'     => getenv('PUBLIC_API_BASE') ?: '',
  ];
}

$cfg = pt_cfg();

$mid        = trim($cfg['PAYTM_MERCHANT_ID']);
$mkey       = trim($cfg['PAYTM_MERCHANT_KEY']);
$website    = trim($cfg['PAYTM_WEBSITE']);
$isProd     = strtolower($cfg['PAYTM_ENV']) === 'prod';

if (empty($mid) || empty($mkey)) {
  http_response_code(500);
  echo json_encode(['error' => 'Paytm credentials missing in config']);
  exit;
}

// ====== ইনপুট ======
$amount      = round((float)($input['amount'] ?? 0), 2);           // INR
$order_id    = $input['order_id'] ?? 'ORD_' . time() . rand(100, 999);
$customer_id = $input['customer_id'] ?? 'CUST_' . time();
$name        = trim($input['name'] ?? 'Customer');
$email       = trim($input['email'] ?? '');
$mobile      = trim($input['mobile'] ?? '');
$description = trim($input['description'] ?? 'Payment');

// ভ্যালিডেশন
if ($amount < 1) {
  http_response_code(400);
  echo json_encode(['error' => 'Minimum amount is ₹1.00']);
  exit;
}

// ====== Paytm URL ======
$paytmHost = $isProd
  ? "https://securegw.paytm.in"
  : "https://securegw-stage.paytm.in";

$callbackUrl = rtrim($cfg['PUBLIC_API_BASE'] ?: "https://{$_SERVER['HTTP_HOST']}" . dirname($_SERVER['REQUEST_URI']), '/')
  . "/paytm-callback.php";

// ====== Paytm চেকসাম জেনারেট ======
require_once __DIR__ . '/paytm-checksum.php';   // নিচে দিলাম এই ফাইলটা

$paytmParams = [
  "MID"             => $mid,
  "WEBSITE"         => $website,
  "INDUSTRY_TYPE_ID" => "Retail",
  "ORDER_ID"        => $order_id,
  "CUST_ID"         => $customer_id,
  "TXN_AMOUNT"      => number_format($amount, 2, '.', ''),
  "CHANNEL_ID"      => "WEB",
  "MOBILE_NO"       => $mobile,
  "EMAIL"           => $email,
  "CALLBACK_URL"    => $callbackUrl,
];

$checksum = getChecksumFromArray($paytmParams, $mkey);

// ====== ফাইনাল রেসপন্স Flutter এর জন্য ======
echo json_encode([
  'success'       => true,
  'order_id'      => $order_id,
  'amount'        => $amount,
  'txnToken'      => $checksum,                    // এটাই মূল টোকেন
  'paytm_url'     => $paytmHost . '/theia/processTransaction',
  'is_staging'    => !$isProd,
  'callback_url'  => $callbackUrl,
], JSON_PRETTY_PRINT);
