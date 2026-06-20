<?php
// iyzico-callback.php
$orderId = $_GET['order'] ?? 'Bilinmiyor';
$amount  = $_GET['amount'] ?? '0.00';
$status  = $_GET['status'] ?? 'success';
$token   = $_GET['token'] ?? ''; // iyzico paymentId

// অপশনাল: এখানে ডাটাবেসে সেভ করো
// logPayment($orderId, $amount, $status, $token);
?>

<!DOCTYPE html>
<html lang="tr">

<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Ödeme Başarılı ✓</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@500;600;700&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" />
  <style>
    :root {
      --primary: #00c853;
      --primary-dark: #00a046;
      --gray: #f8f9fa;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: 'Inter', sans-serif;
      background: linear-gradient(135deg, var(--primary), var(--primary-dark));
      color: white;
      min-height: 100vh;
      display: flex;
      align-items: center;
      justify-content: center;
      padding: 20px;
      overflow: hidden;
    }

    .card {
      background: rgba(255, 255, 255, 0.12);
      backdrop-filter: blur(20px);
      border-radius: 28px;
      padding: 50px 30px;
      width: 100%;
      max-width: 420px;
      text-align: center;
      box-shadow: 0 20px 50px rgba(0, 0, 0, 0.3);
      border: 1px solid rgba(255, 255, 255, 0.1);
      animation: float 6s ease-in-out infinite;
    }

    @keyframes float {

      0%,
      100% {
        transform: translateY(0px);
      }

      50% {
        transform: translateY(-15px);
      }
    }

    .success-icon {
      width: 100px;
      height: 100px;
      background: white;
      margin: 0 auto 30px;
      border-radius: 50px;
      position: relative;
      animation: checkmark 0.8s ease-in-out 0.5s forwards;
    }

    .success-icon::before,
    .success-icon::after {
      content: '';
      position: absolute;
      background: white;
      border-radius: 50px;
    }

    .success-icon::before {
      width: 35px;
      height: 12px;
      left: 20px;
      top: 38px;
      transform: rotate(-45deg);
    }

    .success-icon::after {
      width: 65px;
      height: 12px;
      left: 45px;
      top: 32px;
      transform: rotate(45deg);
    }

    @keyframes checkmark {
      0% {
        height: 0;
        width: 0;
        opacity: 0;
      }

      100% {
        height: 100px;
        width: 100px;
        opacity: 1;
      }
    }

    h1 {
      font-size: 36px;
      font-weight: 700;
      margin: 20px 0 12px;
    }

    .subtitle {
      font-size: 19px;
      opacity: 0.95;
      margin-bottom: 30px;
    }

    .info {
      background: rgba(255, 255, 255, 0.15);
      border-radius: 16px;
      padding: 20px;
      margin: 25px 0;
      font-size: 17px;
    }

    .info strong {
      color: #fff;
      font-weight: 600;
    }

    .btn {
      display: block;
      width: 80%;
      max-width: 300px;
      margin: 35px auto 15px;
      padding: 18px;
      background: white;
      color: var(--primary);
      font-size: 19px;
      font-weight: 600;
      border-radius: 50px;
      text-decoration: none;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.2);
      transition: all 0.3s;
    }

    .btn:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 40px rgba(0, 0, 0, 0.3);
    }

    .manual {
      font-size: 15px;
      margin-top: 20px;
      opacity: 0.9;
    }

    .manual a {
      color: white;
      text-decoration: underline;
    }
  </style>
</head>

<body>

  <div class="card">
    <div class="success-icon"></div>
    <h1>Ödeme Başarılı!</h1>
    <p class="subtitle">Satın alımın tamamlandı</p>

    <div class="info">
      <p>Sipariş No: <strong><?= htmlspecialchars($orderId) ?></strong></p>
      <p>Tutar: <strong><?= number_format((float)$amount, 2) ?> ₺</strong></p>
    </div>

    <a href="myapp://payment-success?order=<?= urlencode($orderId) ?>&amount=<?= $amount ?>&status=success"
      id="appLink"
      class="btn">
      Uygulamaya Dön
    </a>

    <p class="manual">
      Otomatik kapanmazsa
      <a href="myapp://payment-success?order=<?= urlencode($orderId) ?>">buraya tıklayın</a>
    </p>
  </div>

  <script>
    // অটো deep link ট্রাই করা (Android + iOS দুটোতেই কাজ করে)
    function openApp() {
      const link = document.getElementById('appLink');
      const startTime = Date.now();

      // প্রথমে ক্লিক সিমুলেট করি
      link.click();

      // 1.5 সেকেন্ড পরেও যদি পেজ না যায়, তাহলে fallback
      setTimeout(() => {
        const timeDiff = Date.now() - startTime;
        if (timeDiff < 2000 && document.hidden !== true) {
          // অ্যাপ খোলা হয়নি → fallback
          alert("Uygulama bulunamadı. Lütfen uygulamayı açın.");
          // অথবা Google Play / App Store এ পাঠাও:
          // window.location = "https://play.google.com/store/apps/details?id=com.yourapp";
        }
      }, 1500);
    }

    // ১.৫ সেকেন্ড পর অটো চালাও
    setTimeout(openApp, 1500);

    // ইউজার ম্যানুয়ালি চাপলে
    document.getElementById('appLink').addEventListener('click', function(e) {
      e.preventDefault();
      openApp();
    });
  </script>

</body>

</html>
