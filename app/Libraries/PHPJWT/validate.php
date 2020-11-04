<?php
 
require __DIR__ . '/vendor/autoload.php';
use \Firebase\JWT\JWT;
// required headers
header("Access-Control-Allow-Origin: http://localhost/test2.php");
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Max-Age: 3600");
header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
// print_r(json_decode($_POST));
// print_r(json_decode(file_get_contents('php://input'))->jwt);
$jwt = json_decode(file_get_contents('php://input'))->jwt;
$key = "Örnek";
 
if ($jwt) {
    // if decode succeed, show user details
    try {
        // decode jwt
        $decoded = JWT::decode($jwt, $key, array('HS256'));
 
        // set response code
        http_response_code(200);
 
        // show user details
        echo json_encode(array(
            "message" => "Erişim Sağlandı.",
            "data" => $decoded->data
        ));
 
    }// if decode fails, it means jwt is invalid
    catch (Exception $e) {
 
        // set response code
        http_response_code(401);
 
        // tell the user access denied  & show error message
        echo json_encode(array(
            "message" => "Erişim Engellendi.",
            "error" => $e->getMessage()
        ));
    }
}