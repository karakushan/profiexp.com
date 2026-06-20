<?php
// perfectmoney-success.php
header('Content-Type: text/html; charset=utf-8');

// পেমেন্ট থেকে যা আসবে তা নিয়ে নিচ্ছি
$order_id   = $_GET['PAYMENT_ID'] ?? $_POST['PAYMENT_ID'] ?? '';
$amount     = $_GET['PAYMENT_AMOUNT'] ?? $_POST['PAYMENT_AMOUNT'] ?? '';
$batch      = $_GET['PAYMENT_BATCH_NUM'] ?? $_POST['PAYMENT_BATCH_NUM'] ?? '';

// আপনার অ্যাপের deep link (চেঞ্জ করুন যা খুশি)
$deep_link = 'myapp://payment-success';

$query = [];
if ($order_id) $query['order_id']     = $order_id;
if ($amount)   $query['amount']       = $amount;
if ($batch)    $query['batch']        = $batch;
$query['status'] = 'success';

if ($query) {
  $deep_link .= '?' . http_build_query($query);
}
?>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>Payment Success – Returning to App...</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    body {
      font-family: system-ui, Arial;
      text-align: center;
      padding: 50px;
      background: #f0fff0;
    }

    h1 {
      color: green;
    }
  </style>
</head>

<body>
  <h1>Payment Successful!</h1>
  <p>Amount: <strong>$<?php echo htmlspecialchars($amount); ?></strong></p>
  <p>Order ID: <strong><?php echo htmlspecialchars($order_id); ?></strong></p>
  <p>Returning to app...</p>

  <script>
    // অ্যাপে রিডাইরেক্ট
    location.replace("<?php echo $deep_link; ?>");
  </script>

  <!-- যদি জাভাস্ক্রিপ্ট বন্ধ থাকে তাহলে ম্যানুয়াল লিংক -->
  <noscript>
    <a href="<?php echo $deep_link; ?>">Click here to return to app</a>
  </noscript>
</body>

</html>
