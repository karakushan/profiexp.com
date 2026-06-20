<?php
// perfectmoney-fail.php
header('Content-Type: text/html; charset=utf-8');

$order_id = $_GET['PAYMENT_ID'] ?? '';

// আপনার অ্যাপের deep link
$deep_link = 'myapp://payment-failed';
$query = ['status' => 'failed'];
if ($order_id) $query['order_id'] = $order_id;

if ($query) {
  $deep_link .= '?' . http_build_query($query);
}
?>
<!DOCTYPE html>
<html>

<head>
  <meta charset="utf-8">
  <title>Payment Cancelled – Returning...</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <style>
    body {
      font-family: system-ui, Arial;
      text-align: center;
      padding: 50px;
      background: #fff0f0;
    }

    h1 {
      color: red;
    }
  </style>
</head>

<body>
  <h1>Payment Cancelled or Failed</h1>
  <p>You have cancelled the payment or something went wrong.</p>
  <p>Returning to app...</p>

  <script>
    location.replace("<?php echo $deep_link; ?>");
  </script>

  <noscript>
    <a href="<?php echo $deep_link; ?>">Click here to return to app</a>
  </noscript>
</body>
</html>
