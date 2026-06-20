<?php $orderId = $_GET['order'] ?? 'Unknown'; ?>
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Payment Failed</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght:600&display=swap" rel="stylesheet">
  <style>
    body {
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background: #d32f2f;
      color: white;
      height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      text-align: center;
    }

    .box {
      background: rgba(255, 255, 255, 0.15);
      padding: 40px;
      border-radius: 20px;
    }

    h1 {
      font-size: 38px;
      margin: 0 0 15px 0;
    }

    p {
      font-size: 18px;
    }

    .btn {
      display: inline-block;
      margin-top: 25px;
      padding: 14px 32px;
      background: white;
      color: #d32f2f;
      border-radius: 50px;
      text-decoration: none;
      font-weight: bold;
    }
  </style>
</head>

<body>
  <div class="box">
    <h1>Payment Failed</h1>
    <p>Order ID: <?= htmlspecialchars($orderId) ?></p>
    <p>Something went wrong. Please try again.</p>
    <a href="myapp://payment-failed?order=<?= urlencode($orderId) ?>" class="btn">Try Again</a>
    <script>
      setTimeout(() => history.back(), 5000);
    </script>
  </div>
</body>

</html>
