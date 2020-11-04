<?php 
   namespace App\Libraries;
// if ( ! defined('BASEPATH')) exit('No direct script access allowed');
   require __DIR__ . '/PHPJWT/vendor/autoload.php';
   use \Firebase\JWT\JWT;

   class PhpJwt {
        private $key = 'futbolapp';

        public function generateJWT($email,$sifre){
            $issuedAt = time();
            // jwt valid for 60 days (60 seconds * 60 minutes * 24 hours * 60 days)
            $expirationTime = $issuedAt + 60 * 60 * 24 * 7;
            
            $key = $this->key; // bu bizim oluşturacağımız bi nevi şifremiz
            $iss = "http://localhost:80";
            $aud = "http://localhost:80";
            $iat = strtotime('00:00:00');
            $nbf = strtotime('00:00:01');
        
            $token = [
                'iss' => $iss,
                'aud' => $aud,
                'iat' => $iat,
                'nbf' => $nbf,
                'exp' => $expirationTime,
                'data' => [
                    'email' => $email,
                    'sifre' => $sifre
                ]
            ];
        
            http_response_code(200);
        
            $jwt = JWT::encode($token,$key);
            return $jwt;
        }

        public function validateJWT($jwtFromPost){
            // required headers
            // header("Access-Control-Allow-Origin: http://localhost:80/");
            // header("Access-Control-Allow-Methods: POST");
            // header("Access-Control-Max-Age: 3600");
            // header("Access-Control-Allow-Headers: Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");

            $jwt = $jwtFromPost;
            $key = $this->key;
            
            if ($jwt) {
                try {
                    // decode jwt
                $decoded = JWT::decode($jwt, $key, array('HS256'));
             
             
                    // show user details
                    return true;
             
                }// if decode fails, it means jwt is invalid
                catch (\Exception $e) {
             
             
                    // tell the user access denied  & show error message
                    return false;
                }
            }
        }
   }
	
/* End of file PhpJwt.php */