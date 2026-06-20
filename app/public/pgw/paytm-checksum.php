<?php
// paytm-checksum.php
function encrypt_e($input, $key)
{
  $key = html_entity_decode($key);
  $iv = "@@@@&&&&####$$$$";
  return base64_encode(openssl_encrypt($input, "AES-128-CBC", $key, 0, $iv));
}

function decrypt_e($crypt, $key)
{
  $key = html_entity_decode($key);
  $iv = "@@@@&&&&####$$$$";
  return openssl_decrypt(base64_decode($crypt), "AES-128-CBC", $key, 0, $iv);
}

function getChecksumFromArray($arrayList, $key, $sort = 1)
{
  if ($sort != 0) ksort($arrayList);
  $str = "";
  foreach ($arrayList as $k => $v) {
    $str .= $v . "|";
  }
  $str .= $key;
  return hash("sha256", $str);
}

function verifychecksum_e($arrayList, $key, $checksumvalue)
{
  $str = "";
  foreach ($arrayList as $k => $v) $str .= $v . "|";
  $str .= $key;
  $check = hash("sha256", $str);
  return $check === $checksumvalue;
}
