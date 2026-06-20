<?php
// Small helper lib for PayPal Orders API v2

function pp_cfg(): array
{
  foreach ([__DIR__ . '/config.php', dirname(__DIR__) . '/config.php', dirname(__DIR__, 2) . '/config.php'] as $p) {
    if (is_file($p)) return require $p;
  }
  return [
    'PAYPAL_CLIENT_ID' => getenv('PAYPAL_CLIENT_ID') ?: '',
    'PAYPAL_SECRET'    => getenv('PAYPAL_SECRET') ?: '',
    'PAYPAL_BASE'      => getenv('PAYPAL_BASE') ?: 'https://api-m.sandbox.paypal.com',
    'PUBLIC_API_BASE'  => getenv('PUBLIC_API_BASE') ?: '',
    'PAYPAL_SSL_VERIFY' => getenv('PAYPAL_SSL_VERIFY') !== false
      ? filter_var(getenv('PAYPAL_SSL_VERIFY'), FILTER_VALIDATE_BOOLEAN)
      : true,
    'PAYPAL_CURL_CA_BUNDLE' => getenv('PAYPAL_CURL_CA_BUNDLE') ?: '',
  ];
}

function pp_apply_ssl_options(array $cfg, array &$opts): void
{
  $verify = $cfg['PAYPAL_SSL_VERIFY'] ?? true;

  if (is_string($verify)) {
    $verify = !in_array(strtolower(trim($verify)), ['0', 'false', 'off', 'no'], true);
  }

  $verify = (bool) $verify;

  $opts[CURLOPT_SSL_VERIFYPEER] = $verify;
  $opts[CURLOPT_SSL_VERIFYHOST] = $verify ? 2 : 0;

  $caBundle = trim((string)($cfg['PAYPAL_CURL_CA_BUNDLE'] ?? ''));
  if ($verify && $caBundle !== '' && is_file($caBundle)) {
    $opts[CURLOPT_CAINFO] = $caBundle;
  }
}

function pp_access_token(string $base, string $clientId, string $secret): string
{
  $cfg = pp_cfg();

  $cache = sys_get_temp_dir() . '/pp_token.json';
  if (is_file($cache)) {
    $j = json_decode((string)file_get_contents($cache), true);
    if (!empty($j['access_token']) && !empty($j['exp']) && $j['exp'] > time() + 30) {
      return $j['access_token'];
    }
  }
  $url = rtrim($base, '/') . '/v1/oauth2/token';
  $ch = curl_init($url);
  $opts = [
    CURLOPT_POST => true,
    CURLOPT_HTTPHEADER => ['Content-Type: application/x-www-form-urlencoded'],
    CURLOPT_USERPWD => $clientId . ':' . $secret,
    CURLOPT_POSTFIELDS => 'grant_type=client_credentials',
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_TIMEOUT => 30,
  ];
  pp_apply_ssl_options($cfg, $opts);
  curl_setopt_array($ch, $opts);
  $resBody = curl_exec($ch);
  $err = curl_error($ch);
  $code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  curl_close($ch);
  if ($err) throw new Exception('PayPal token error: ' . $err);
  $js = json_decode($resBody, true);
  if ($code >= 300 || empty($js['access_token'])) {
    throw new Exception('PayPal token http ' . $code . ': ' . $resBody);
  }
  $exp = time() + (int)($js['expires_in'] ?? 300);
  @file_put_contents($cache, json_encode(['access_token' => $js['access_token'], 'exp' => $exp - 60]));
  return $js['access_token'];
}

function pp_request(string $method, string $url, array $headers, $body = null): array
{
  $cfg = pp_cfg();

  $ch = curl_init($url);
  $opts = [
    CURLOPT_CUSTOMREQUEST => $method,
    CURLOPT_HTTPHEADER => $headers,
    CURLOPT_RETURNTRANSFER => true,
    CURLOPT_TIMEOUT => 45,
  ];
  pp_apply_ssl_options($cfg, $opts);
  if ($body !== null) $opts[CURLOPT_POSTFIELDS] = is_string($body) ? $body : json_encode($body);
  curl_setopt_array($ch, $opts);
  $resBody = curl_exec($ch);
  $err = curl_error($ch);
  $code = curl_getinfo($ch, CURLINFO_HTTP_CODE);
  curl_close($ch);
  if ($err) return [$code ?: 0, ['error' => $err]];
  $js = json_decode($resBody, true);
  return [$code, is_array($js) ? $js : ['raw' => $resBody]];
}
