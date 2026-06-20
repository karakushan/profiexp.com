<?php $orderId = $_GET['order'] ?? 'Unknown'; ?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Payment Cancelled</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght:600&display=swap" rel="stylesheet">
  <style>
    body {
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background: #ff9800;
      color: white;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
    }

    .box {
      background: rgba(0, 0, 0, 0.2);
      padding: 40px;
      border-radius: 20px;
    }

    h1 {
      font-size: 38px;
      margin: 0 0 15px 0;
    }

    .btn {
      display: inline-block;
      margin-top: 25px;
      padding: 14px 32px;
      background: white;
      color: #ff9800;
      border-radius: 50px;
      text-decoration: none;
      font-weight: bold;
    }
  </style>
</head>

<body>
  <div class="box">
    <h1>Payment Cancelled</h1>
    <p>Order ID: <?= htmlspecialchars($orderId) ?></p>
    <p>You cancelled the payment.</p>
    <a href="myapp://payment-cancelled" class="btn">Back to App</a>
    <script>
      setTimeout(() => history.back(), 5000);
    </script>
  </div>
</body>

</html>
