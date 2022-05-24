<?php 

require_once 'clases/conexion/conexion.php';
require_once 'clases/asesor.class.php';

$conexion = new conexion();
$asesor = new asesor();

$query = "CALL getAsesors";

$listasesor = $conexion->obtenerDatos($query);
$resultsArray = array();

/* var_dump($asesor->obtenerclientes(5));
var_dump($asesor->obtenerclientes(3)); */

header('Content-Type: application/json');
foreach ($listasesor as $key) {
           
    $id = $key['id_asesor'];                   
    $resultsArray[]= 
    ["codigo_asesor"=>$key['codigo_asesor'],
     "asesor"=>$key['asesor'],
     "id_asesor"=>$key['id_asesor'],
     "clientes_asignados"=>$key['clientes_asignados'], 
     "total_pedido"=>$key['total_pedido'],
     "clientes" => $asesor->obtenerclientes($id)
    ];
                          
} 

echo json_encode($resultsArray, JSON_PRETTY_PRINT);






