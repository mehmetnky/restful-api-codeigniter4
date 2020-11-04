<?php namespace App\Controllers;

class Home extends BaseController
{
	// private $db = $this->db;
	public function index()
	{
		
		if($this->setIsAllowed('GET')){
			$body = array(
				"success"=>true
			);
			$this->response->setStatusCode(200);
			return $this->response->setJSON($body);
		}

		// $data = $this->request->getJSON();

		// if($this->jwt->validateJWT($data->jwt)){
		// 	$this->response->setStatusCode(200);
		// 	return $this->response->setJSON(array("status"=>true));
		// }else{
		// 	$this->response->setStatusCode(400);
		// 	return $this->response->setJSON(array("status"=>false));
		// }
		
	}

	public function login(){
		if($this->setIsAllowed('POST')){
			$data = $this->request->getJSON();

			$builder = $this->db->table('oyuncular');
			$builder->select('id,email,sifre');
			$builder->where('oyuncular.email',$data->email);
			$query = $builder->get();

			$id = $query->getRow()->id;
			$sifre = $query->getRow()->sifre;

			if(password_verify($data->sifre,$sifre)){
				$jwt = $this->jwt->generateJWT($data->email,$data->sifre);

				$dataToUpdate = [
					'accessToken' => $jwt
				];
				$builder = $this->db->table('oyuncular');
				$builder->where('email',$data->email);
				$builder->update($dataToUpdate);
					
				$body = array(
					"status"=>true,
					"accessToken"=>$jwt
				);
				$this->response->setStatusCode(200);
				return $this->response->setJSON($body);
			}else{
				$body = array(
					"status"=>false
				);
				$this->response->setStatusCode(400);
				return $this->response->setJSON($body);
			}

		}
	}

	public function register(){
		if($this->setIsAllowed('POST')){
			$data = $this->request->getJSON();

			$builder = $this->db->table('oyuncular');
			$builder->select('email');
			$builder->where('oyuncular.email',$data->email);
			$query = $builder->get();

			if($query->getRow()){
				$body = array(
					"status"=>false,
					"err"=>"Email already exists"
				);
				$this->response->setStatusCode(400);
				return $this->response->setJSON($body);
			}else{
				$builder->resetQuery();
				$builder = $this->db->table('oyuncular');

				$data->sifre = password_hash($data->sifre, PASSWORD_DEFAULT);

				$jwt = $this->jwt->generateJWT($data->email,$data->sifre);
				$data->accessToken = $jwt;
				$builder->set($data);
				$query = $builder->insert();

				if($query->connID->affected_rows){
					$body = array(
						"status"=>true,
						"process"=>"Data Inserted",
						"playerData"=>[
							"id"=>$query->connID->insert_id,
							"accessToken"=>$jwt
						]
					);
					$this->response->setStatusCode(200);
					return $this->response->setJSON($body);
				}else{
					$body = array(
						"status"=>false,
						"process"=>"Falsy Data"
					);
					$this->response->setStatusCode(400);
					return $this->response->setJSON($body);
				}

			}
			
		}
	}

	//--------------------------------------------------------------------

}
