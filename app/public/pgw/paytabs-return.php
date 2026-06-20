<?php
$tran_ref = trim((string)($_GET['tran_ref'] ?? $_POST['tran_ref'] ?? ''));
$status = strtoupper(trim((string)($_GET['resp_status'] ?? $_POST['resp_status'] ?? '')));
$message = trim((string)($_GET['resp_message'] ?? $_POST['resp_message'] ?? ''));

$scheme = 'myapp://paytabs-finish';
$params = [];

if ($tran_ref !== '') {
  $params['tran_ref'] = $tran_ref;
}

if ($status !== '') {
  $params['status'] = $status;
}

if ($message !== '') {
  $params['message'] = $message;
}

if (!empty($params)) {
  $scheme .= '?' . http_build_query($params);
}

header('Content-Type: text/html; charset=utf-8');
?>
<!doctype html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Returning to App</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      margin: 0;
      min-height: 100vh;
      display: grid;
      place-items: center;
      background: #f5f7fb;
      color: #1f2937;
    }

    .card {
      width: min(92vw, 460px);
      background: #fff;
      border-radius: 14px;
      box-shadow: 0 10px 30px rgba(0, 0, 0, 0.08);
      padding: 24px;
      text-align: center;
    }

    .btn {
      display: inline-block;
      margin-top: 12px;
      background: #2563eb;
      color: #fff;
      text-decoration: none;
      padding: 10px 14px;
      border-radius: 8px;
      font-weight: 600;
    }
  </style>
</head>
<body>
  <div class="card">
    <h2>Returning to app...</h2>
    <p>If nothing happens, tap the button below.</p>
    <a class="btn" href="<?= htmlspecialchars($scheme, ENT_QUOTES) ?>">Return to app</a>
  </div>

  <script>
    location.replace('<?= htmlspecialchars($scheme, ENT_QUOTES) ?>');
  </script>
</body>
</html>
