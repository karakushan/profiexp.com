<?php
// paytm-callback.php → config.php যদি public এ থাকে (এক লেভেল উপরে)

http_response_code(200);

// ====== config.php লোড (এক লেভেল উপরে) ======
$configPath = dirname(__DIR__) . '/config.php';   // ← এটাই ম্যাজিক লাইন
if (!file_exists($configPath)) {
  error_log("config.php not found at: " . $configPath);
  die("Config missing");
}
$cfg = require $configPath;

// ====== paytm-checksum.php লোড (একই ফোল্ডারে) ======
$checksumFile = __DIR__ . '/paytm-checksum.php';
if (!file_exists($checksumFile)) {
  die("paytm-checksum.php missing");
}
require_once $checksumFile;

// ====== মূল কাজ ======
$mkey = trim($cfg['PAYTM_MERCHANT_KEY']);

$logDir = __DIR__;  // pgw ফোল্ডার

// সব রিকোয়েস্ট লগ
file_put_contents(
  $logDir . '/paytm_callback.log',
  date('Y-m-d H:i:s') . " | IP: " . $_SERVER['REMOTE_ADDR'] . " | POST: " . json_encode($_POST) . "\n",
  FILE_APPEND | LOCK_EX
);

// চেকসাম ভেরিফাই
$paytmChecksum = $_POST['CHECKSUMHASH'] ?? '';
$isValid = verifychecksum_e($_POST, $mkey, $paytmChecksum);

if ($isValid && ($_POST['STATUS'] ?? '') === 'TXN_SUCCESS') {

  $order_id = $_POST['ORDERID'] ?? '';
  $amount   = $_POST['TXNAMOUNT'] ?? '';
  $txn_id   = $_POST['TXNID'] ?? '';

  file_put_contents(
    $logDir . '/paytm_success.log',
    date('Y-m-d H:i:s') . " | SUCCESS | Order: $order_id | ₹$amount | TXN: $txn_id\n",
    FILE_APPEND | LOCK_EX
  );

  // ← এখানে আপনার DB আপডেট করবেন
  // update_order($order_id, 'paid', $amount, $txn_id);

} else {
  $msg = $_POST['RESPMSG'] ?? 'Checksum failed or transaction failed';
  file_put_contents(
    $logDir . '/paytm_failed.log',
    date('Y-m-d H:i:s') . " | FAILED | $msg | ORDERID: " . $_POST['ORDERID'] . "\n",
    FILE_APPEND | LOCK_EX
  );
}

echo "OK";
