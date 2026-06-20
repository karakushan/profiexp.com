<?php
// yoco-success.php
$orderId = $_GET['order'] ?? 'UNKNOWN';
$amount  = $_GET['amount'] ?? '0.00';
$status  = $_GET['status'] ?? 'success';
?>

<!DOCTYPE html>
<html lang="tr">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Ödeme Tamamlandı</title>
  <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500;600;700&display=swap" rel="stylesheet">
  <style>
    body {
      margin: 0;
      font-family: 'Poppins', sans-serif;
      background: linear-gradient(135deg, #00c853, #00a046);
      color: white;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      text-align: center;
    }

    .container {
      background: rgba(255, 255, 255, 0.12);
      backdrop-filter: blur(16px);
      border-radius: 24px;
      padding: 50px 30px;
      max-width: 90%;
      box-shadow: 0 15px 40px rgba(0, 0, 0, 0.4);
      border: 1px solid rgba(255, 255, 255, 0.2);
    }

    .check {
      width: 90px;
      height: 90px;
      background: white;
      border-radius: 50%;
      margin: 0 auto 30px;
      position: relative;
      animation: pulse 2s infinite;
    }

    .check::after {
      content: "✓";
      position: absolute;
      color: #00c853;
      font-size: 56px;
      font-weight: bold;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }

    @keyframes pulse {
      0% {
        box-shadow: 0 0 0 0 rgba(255, 255, 255, 0.7);
      }

      70% {
        box-shadow: 0 0 0 20px rgba(255, 255, 255, 0);
      }

      100% {
        box-shadow: 0 0 0 0 rgba(255, 255, 255, 0);
      }
    }

    h1 {
      font-size: 38px;
      margin: 0 0 15px;
    }

    p {
      font-size: 18px;
      margin: 12px 0;
      opacity: 0.95;
    }

    .btn {
      display: block;
      margin: 35px auto 0;
      padding: 16px 40px;
      background: white;
      color: #00c853;
      font-weight: bold;
      font-size: 19px;
      border-radius: 50px;
      text-decoration: none;
      width: fit-content;
      box-shadow: 0 10px 25px rgba(0, 0, 0, 0.3);
      transition: 0.3s;
    }

    .btn:hover {
      transform: translateY(-4px);
    }

    .manual {
      margin-top: 25px;
      font-size: 15px;
    }

    .manual a {
      color: white;
      text-decoration: underline;
    }
  </style>
</head>

<body>

  <div class="container">
    <div class="check"></div>
    <h1>Ödeme Başarılı!</h1>
    <p>Sipariş Numaranız</p>
    <p style="font-size:22px;font-weight:700;"><?= htmlspecialchars($orderId) ?></p>
    <p>Tutar: <strong><?= number_format((float)$amount, 2) ?> ₺</strong></p>

    <!-- এই লিঙ্কে ক্লিক করলেই অ্যাপে ফিরে যাবে -->
    <a href="myapp://payment-success?order=<?= urlencode($orderId) ?>&amount=<?= $amount ?>&status=success"
      id="returnApp"
      class="btn">
      Uygulamaya Dön
    </a>

    <div class="manual">
      Otomatik yönlenmiyorsanız
      <a href="myapp://payment-success?order=<?= urlencode($orderId) ?>">buraya tıklayın</a>
    </div>
  </div>

  <script>
    // সবচেয়ে কার্যকরী deep link ট্রিক (Android + iOS দুটোতেই কাজ করে)
    function returnToApp() {
      const link = document.getElementById('returnApp');
      const clickedAt = Date.now();

      // লিঙ্কে ক্লিক করা সিমুলেট করি
      link.click();

      // ১.৫ সেকেন্ড পর চেক করি অ্যাপ খুলেছে কিনা
      setTimeout(() => {
        // যদি এখনো এই পেজে থাকে, মানে অ্যাপ খোলা হয়নি
        if (Date.now() - clickedAt < 2000) {
          alert("Uygulama açılamadı. Lütfen uygulamayı manuel açın.");
          // অথবা Play Store / App Store এ পাঠাও:
          // window.location = "https://play.google.com/store/apps/details?id=com.yourapp.package";
        }
      }, 1500);
    }

    // ১.৫ সেকেন্ড পর অটো চালাও
    setTimeout(returnToApp, 1500);

    // ইউজার নিজে চাপলে
    document.getElementById('returnApp').addEventListener('click', function(e) {
      e.preventDefault();
      returnToApp();
    });
  </script>

</body>

</html>
