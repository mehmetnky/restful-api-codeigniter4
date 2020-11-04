<?php namespace App\Controllers;

class Teams extends BaseController
{
	public function index($id = false)
	{
		if($this->setIsAllowed('GET')){
            $jwt = explode(' ',$this->request->getHeader('Authorization')->getValue())[1];
            if($this->jwt->validateJWT($jwt)){
                $builder = $this->db->table('takimlar');
                $builder->select('takimlar.ad, 
                                arma,
                                kurucu_oyuncu_id,
                                oyuncular.ad as kurucu_oyuncu_ad,
                                oyuncular.soyad as kurucu_oyuncu_soyad,
                                oyuncular.foto as kurucu_oyuncu_img,
                                kurulus_tarihi');
                if($id && is_numeric($id)){
                    $builder->join('oyuncular', 'oyuncular.id = takimlar.kurucu_oyuncu_id');
                    $builder->where('takimlar.id',$id);
                    $query = $builder->get();
                    $body = array(
                        "status"=>true,
                        "data"=>$query->getRow()
                    );
                    $this->response->setStatusCode(200);
                    return $this->response->setJSON($body);
                }else{
                    $builder->join('oyuncular', 'oyuncular.id = takimlar.kurucu_oyuncu_id');
                    $query = $builder->get();
                    $body = array(
                        "status"=>true,
                        "data"=>$query->getResult()
                    );
                    $this->response->setStatusCode(200);
                    return $this->response->setJSON($body);
                }
			}else{
                $this->response->setStatusCode(400);
                return $this->response->setJSON(array("status"=>false,"err"=>'Auth Failed'));
            }
		}
		
	}

	//--------------------------------------------------------------------

}
