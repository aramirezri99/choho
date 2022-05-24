<?php

require_once 'conexion/conexion.php';


class asesor{
    
    public function obtenerclientes($id){
        $query = "CALL getClientes(".$id.")";
        $conexion = new conexion();
        $datos = $conexion->obtenerDatos($query);

        foreach ($datos as $key) {
           
            $id = $key['id_asesor'];                   
            $resultsArray[]= 
            [
               "id_cliente"=>$key['id_cliente'],
               "cliente"=>$key['cliente'],
               "total_pedidos"=>$key['total_pedidos'],
               "id_asesor"=>$key['id_asesor'],
               "detalle_pedidos"=> $this->getDetalle($key['id_cliente'],$key['id_asesor'])
             
            ];
                                  
        } 

        
        return $resultsArray;
    }


    public function getDetalle($id_cliente,$id_asesor){

        $query = "CALL getdetalle(".$id_cliente.",". $id_asesor.")";
        $conexion = new conexion();
        $datos = $conexion->obtenerDatos($query);
        $resultsArray = array();
        foreach ($datos as $key) {
                       
            $resultsArray[]=  [
                "id_pedido"=>$key['id_pedido'],
                "fecha_pago"=>$key['fecha_pago'],
                "estado"=>$key['estado'],
                "total_productos"=>$key['total_productos'],
                "total_pedido"=>$key['total_pedido'],
                "productos"=> $this->getProducto($id_cliente,$id_asesor)
              
            ];
        } 
        
        return $resultsArray;

    } 

    public function getProducto($id_cliente,$id_asesor){

        $query = "CALL getproduct(".$id_cliente.",". $id_asesor.")";
        $conexion = new conexion();
        $datos = $conexion->obtenerDatos($query);
        $resultsArray = array();
        foreach ($datos as $key) {
                       
            $resultsArray[]= $key;
                                  
        } 
        
        return $resultsArray;

    } 

    
}
    