<?php
// paytabs-callback.php
// এই ফাইলটা কখনো ব্রাউজারে ওপেন করবেন না — শুধু PayTabs কল করবে

http_response_code(200);
header('Content-Type: application/json');

$log_file = sys_get_temp_dir() . '/paytabs_callback.log';
function cb_log($msg)
{
  global $log_file;
  @file_put_contents($log_file, date('Y-m-d H:i:s') . " | $msg\n", FILE_APPEND | LOCK_EX);
}

$input = file_get_contents('php://input');
$payload = json_decode($input, true);

cb_log("=== CALLBACK RECEIVED ===");
cb_log("Raw POST: " . $input);
cb_log("Server vars: " . print_r($_SERVER, true));

if (!$payload) {
  cb_log("Invalid JSON");
  exit;
}

// গুরুত্বপূর্ণ ফিল্ডগুলো
$tran_ref     = $payload['tran_ref'] ?? '';
$cart_id      = $payload['cart_id'] ?? '';
$payment_status = $payload['payment_result']['response_status'] ?? '';
$resp_message   = $payload['payment_result']['response_message'] ?? '';
$amount         = $payload['cart_amount'] ?? '';

// এখানে আপনার ডাটাবেসে অর্ডার স্ট্যাটাস আপডেট করবেন
// উদাহরণ (আপনার সিস্টেম অনুযায়ী চেঞ্জ করুন):

if ($payment_status === 'A') {
  // Payment Successful
  cb_log("SUCCESS | Order: $cart_id | Tran: $tran_ref | Amount: $amount");

  // TODO: এখানে আপনার ডাটাবেসে লিখুন
  // Example:
  // update_order_status($cart_id, 'paid', $tran_ref);

  // ইমেইল পাঠাতে চাইলে এখানে করুন
  // send_payment_success_email($cart_id);

} else {
  // Payment Failed / Cancelled / Pending
  cb_log("FAILED | Order: $cart_id | Status: $payment_status | Message: $resp_message");

  // update_order_status($cart_id, 'failed');
}

cb_log("=== END CALLBACK ===\n");

// PayTabs কে বলুন: আমি পেয়েছি
echo json_encode(['status' => 'OK']);
