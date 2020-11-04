<?php
require __DIR__ . '/vendor/autoload.php';
use \Firebase\JWT\JWT;
 
date_default_timezone_set('Europe/Istanbul');
 
if (!empty($_POST)) {
    $key = "Örnek"; // bu bizim oluşturacağımız bi nevi şifremiz
    $iss = "http://localhost:80";
    $aud = "http://localhost:80";
    $iat = strtotime('00:00:00');
    $nbf = strtotime('00:00:01');
 
    $token = [
        'iss' => $iss,
        'aud' => $aud,
        'iat' => $iat,
        'nbf' => $nbf,
        'data' => [
            'id' => 3,
            'firstname' => 'test',
            'email' => 'test'
        ]
    ];
 
    http_response_code(200);
 
    $jwt = JWT::encode($token,$key);
    echo $jwt;
}