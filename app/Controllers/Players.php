<?php namespace App\Controllers;

class Players extends BaseController
{
	public function index($id = false)
	{
		if($this->setIsAllowed('GET')){
            $jwt = explode(' ',$this->request->getHeader('Authorization')->getValue())[1];
            if($this->jwt->validateJWT($jwt)){
                $builder = $this->db->table('oyuncular');
                $builder->select('oyuncular.id as id,
                                ad, 
                                soyad,
                                foto,
                                dogum_gunu,
                                (SELECT year(curdate())-year(dogum_gunu) - (right(curdate(),5) < right(dogum_gunu,5))) as yas,
                                (SELECT mevki from mevkiler where mevkiler.id = oyuncular.mevki_id) as mevki,
                                (SELECT mevki from mevkiler where mevkiler.id = oyuncular.ikincil_mevki_id) as ikincil_mevki,
                                (SELECT beden from forma_bedenler where forma_bedenler.id = oyuncular.forma_beden_id) as forma_beden,
                                boy,
                                kilo,
                                ayakkabi_numarasi,
                                ayak,
                                takim_id,
                                (SELECT ad from takimlar where takimlar.id = formasyonlar.takim_id) as takim_adi');
                $builder->join('formasyonlar', 'oyuncular.id = formasyonlar.oyuncu_id', 'left');
                $builder->groupBy("oyuncular.id");
                if($id && is_numeric($id)){
                    $builder->where('oyuncular.id',$id);
                    $query = $builder->get();
                    $body = array(
                        "status"=>true,
                        "data"=>$query->getRow()
                    );
                    $this->response->setStatusCode(200);
                    return $this->response->setJSON($body);
                }else{
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
    
    public function byTeam($id = false)
    {
        if($this->setIsAllowed('GET')){
            $jwt = explode(' ',$this->request->getHeader('Authorization')->getValue())[1];
            if($this->jwt->validateJWT($jwt)){
                $builder = $this->db->table('oyuncular');
                $builder->select('oyuncular.id as id,
                                ad, 
                                soyad,
                                foto,
                                dogum_gunu,
                                (SELECT year(curdate())-year(dogum_gunu) - (right(curdate(),5) < right(dogum_gunu,5))) as yas,
                                (SELECT mevki from mevkiler where mevkiler.id = oyuncular.mevki_id) as mevki,
                                (SELECT mevki from mevkiler where mevkiler.id = oyuncular.ikincil_mevki_id) as ikincil_mevki,
                                (SELECT beden from forma_bedenler where forma_bedenler.id = oyuncular.forma_beden_id) as forma_beden,
                                boy,
                                kilo,
                                ayakkabi_numarasi,
                                ayak,
                                takim_id,
                                (SELECT ad from takimlar where takimlar.id = formasyonlar.takim_id) as takim_adi,
                                onbirdeMi');
                $builder->join('formasyonlar', 'oyuncular.id = formasyonlar.oyuncu_id');
                if($id && is_numeric($id)){
                    $builder->where('formasyonlar.takim_id',$id);
                    $query = $builder->get();
                    $body = array(
                        "status"=>true,
                        "data"=>$query->getResult()
                    );
                    $this->response->setStatusCode(200);
                    return $this->response->setJSON($body);
                }else{
                    $query = $builder->get();
                    $body = array(
                        "status"=>false,
                        "data"=>'Please use a valid team id'
                    );
                    $this->response->setStatusCode(400);
                    return $this->response->setJSON($body);
                }
			}else{
                $this->response->setStatusCode(400);
                return $this->response->setJSON(array("status"=>false,"err"=>'Auth Failed'));
            }
		}
    }

}
