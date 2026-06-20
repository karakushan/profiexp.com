<?php
// perfectmoney-ipn.php
http_response_code(200);
header('Content-Type: text/plain');

// === config লোড করি (একই সিস্টেম যেমন create.php এ আছে) ===
function pm_cfg(): array
{
  foreach ([__DIR__ . '/config.php', dirname(__DIR__) . '/config.php'] as $p) {
    if (is_file($p)) return require $p;
  }
  return [
    'PM_WALLET'       => getenv('PM_WALLET') ?: 'U45424907',
    'PM_PASS'         => getenv('PM_PASS') ?: '',        // ← এখান থেকে নেবে
    'PM_NAME'         => getenv('PM_NAME') ?: 'My Store',
    'PUBLIC_API_BASE' => getenv('PUBLIC_API_BASE') ?: '',
  ];
}

$cfg        = pm_cfg();
$passphrase = strtoupper(md5(trim($cfg['PM_PASS'])));   // ← এটাই ম্যাজিক
$my_wallet  = trim($cfg['PM_WALLET']);

// লগ ফাইল (যদি চান)
$log_file = '/tmp/perfectmoney_ipn.log';
function ipn_log($msg)
{
  global $log_file;
  @file_put_contents($log_file, date('Y-m-d H:i:s') . " | $msg\n", FILE_APPEND | LOCK_EX);
}

// === Perfect Money V2 Hash চেক ===
$v2_hash = $_POST['V2_HASH'] ?? '';

$hash_string = ($_POST['PAYMENT_ID'] ?? '') . ':' .
  ($_POST['PAYEE_ACCOUNT'] ?? '') . ':' .
  ($_POST['PAYMENT_AMOUNT'] ?? '') . ':' .
  ($_POST['PAYMENT_UNITS'] ?? '') . ':' .
  ($_POST['PAYMENT_BATCH_NUM'] ?? '') . ':' .
  ($_POST['PAYER_ACCOUNT'] ?? '') . ':' .
  $passphrase . ':' .
  ($_POST['TIMESTAMPGMT'] ?? '');

$calculated_hash = strtoupper(md5($hash_string));

ipn_log("IPN Received | From IP: " . $_SERVER['REMOTE_ADDR']);
ipn_log("Expected Wallet: $my_wallet | Received: " . $_POST['PAYEE_ACCOUNT']);
ipn_log("Calculated Hash: $calculated_hash | Received Hash: $v2_hash");

// মূল চেকিং
if ($calculated_hash === $v2_hash) {

  // আমার ওয়ালেটে এসেছে কিনা চেক
  if (strtoupper($_POST['PAYEE_ACCOUNT'] ?? '') === strtoupper($my_wallet)) {

    if (($_POST['PAYMENT_STATUS'] ?? '') === 'Completed') {

      $order_id = $_POST['PAYMENT_ID'] ?? 'unknown';
      $amount   = $_POST['PAYMENT_AMOUNT'] ?? '0';
      $batch    = $_POST['PAYMENT_BATCH_NUM'] ?? '';

      ipn_log("SUCCESS | Order: $order_id | Amount: $amount USD | Batch: $batch");

      // এখানে আপনার ডাটাবেসে ক্রেডিট করুন
      // উদাহরণ:
      // update_order_status($order_id, 'paid', $amount, $batch);

      file_put_contents(
        '/tmp/pm_success.log',
        date('Y-m-d H:i:s') . " | PAID | $order_id | $amount | Batch: $batch\n",
        FILE_APPEND
      );
    } else {
      ipn_log("NOT Completed | Status: " . $_POST['PAYMENT_STATUS']);
    }
  } else {  
    ipn_log("Wrong Payee Account!");
  }
} else {
  ipn_log("INVALID HASH! Possible Fraud!");
}

echo "OK";
