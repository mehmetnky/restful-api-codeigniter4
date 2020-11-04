<?php
namespace App\Controllers;

/**
 * Class BaseController
 *
 * BaseController provides a convenient place for loading components
 * and performing functions that are needed by all your controllers.
 * Extend this class in any new controllers:
 *     class Home extends BaseController
 *
 * For security be sure to declare any new methods as protected or private.
 *
 * @package CodeIgniter
 */

use CodeIgniter\Controller;
// use App\Libraries;

class BaseController extends Controller
{

	/**
	 * An array of helpers to be loaded automatically upon
	 * class instantiation. These helpers will be available
	 * to all other controllers that extend BaseController.
	 *
	 * @var array
	 */
	protected $helpers = [];
	protected $db;
	protected $isAllowed = false;
	protected $jwt;
	protected $request;

	/**
	 * Constructor.
	 */
	public function initController(\CodeIgniter\HTTP\RequestInterface $request, \CodeIgniter\HTTP\ResponseInterface $response, \Psr\Log\LoggerInterface $logger)
	{
		// Do Not Edit This Line
		parent::initController($request, $response, $logger);

		//--------------------------------------------------------------------
		// Preload any models, libraries, etc, here.
		//--------------------------------------------------------------------
		// E.g.:
		// $this->session = \Config\Services::session();

		$this->db = \Config\Database::connect();
		$this->jwt = new \App\Libraries\PhpJwt();
		$this->request = \Config\Services::request();
	}

	protected function setIsAllowed($allowedMethod){
		if($_SERVER['REQUEST_METHOD'] == $allowedMethod){
			$this->response->setHeader('Access-Control-Allow-Methods',$allowedMethod)
							->setHeader("Content-Type","application/json; charset=UTF-8")
							->setHeader("Access-Control-Allow-Origin", "http://localhost:80/")
							->setHeader("Access-Control-Max-Age", "3600")
							->setHeader("Access-Control-Allow-Headers","Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
			$this->isAllowed = true;
		}

		return $this->isAllowed;
	}

	// protected function generateJWT(){
	// 	if (!empty($_POST)) {
	// 		$key = "Örnek"; // bu bizim oluşturacağımız bi nevi şifremiz
	// 		$iss = "http://localhost:80";
	// 		$aud = "http://localhost:80";
	// 		$iat = strtotime('00:00:00');
	// 		$nbf = strtotime('00:00:01');
		 
	// 		$token = [
	// 			'iss' => $iss,
	// 			'aud' => $aud,
	// 			'iat' => $iat,
	// 			'nbf' => $nbf,
	// 			'data' => [
	// 				'id' => 3,
	// 				'firstname' => 'test',
	// 				'email' => 'test'
	// 			]
	// 		];
		 
	// 		http_response_code(200);
		 
	// 		$jwt = JWT::encode($token,$key);
	// 		echo $jwt;
	// 	}
	// }

}
