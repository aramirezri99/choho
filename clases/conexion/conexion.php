<?php 

class conexion {

    private $server;
    private $user;
    private $password;
    private $database;
    private $port;

    private $conexion;

    function __construct(){
        $lista = $this->connect();
        
        foreach ($lista as $key => $value) {
            
            $this->server= $value['server'];           
            $this->user=$value['user'];           
            $this->password=$value['password'];           
            $this->database= $value['database'];           
            $this->port= $value['port'];           
        }

        $this->conexion= new mysqli($this->server,$this->user,$this->password,$this->database,$this->port);
        if ($this->conexion->connect_error) {
            echo "Algo va mal en la conexion";
            die();
        }
        
    }

    private function connect(){

        $direcion = dirname(__FILE__);
        $jasondata = file_get_contents($direcion ."/". "config");
        return json_decode($jasondata,true);
    }


    public function obtenerDatos($query) {

        $results = $this->conexion->query($query);
        $resultsArray = array();
        if (!$results==null) {
            foreach ($results as $key) {
                
                $resultsArray[]= $key;
            }
        }else{
            $resultsArray[]= ["vacio"];
        }
        return $resultsArray;
    }

   
}
