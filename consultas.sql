
-- consulta para obtener los asesores-- 
-- ************************************************************ -- 
SELECT DISTINCT(a.name) AS asesor,a.codigo_asesor,a.id_asesor AS id_asesor,
(SELECT COUNT(DISTINCT(pedido.id_cliente)) FROM pedido WHERE pedido.id_asesor =a.id_asesor) AS clientes_asignados,
(SELECT COUNT(pedido.id_cliente) FROM pedido WHERE pedido.id_asesor =a.id_asesor) AS total_pedido


FROM pedido p INNER JOIN cliente c 
ON p.id_cliente = c.id_cliente INNER JOIN asesor a ON p.id_asesor = a.id_asesor

-- consulta para obtener los clientes asignados -- recibe como paremetro id_asesor
-- ************************************************************ -- 
SELECT 

DISTINCT(p.id_cliente),
(SELECT cliente.name FROM cliente WHERE id_cliente=p.id_cliente) AS cliente,
(SELECT COUNT(pedido.id_cliente) FROM pedido WHERE id_asesor=p.id_asesor and id_cliente=p.id_cliente) AS total_pedidos,
a.id_asesor,
(SELECT asesor.name FROM asesor WHERE id_asesor=a.id_asesor) AS asesor

FROM pedido p INNER JOIN cliente c 
ON p.id_cliente = c.id_cliente INNER JOIN asesor a ON p.id_asesor = a.id_asesor
 WHERE p.id_asesor=3



-- consulta para obtener detalle total-- ecibe como paremetro id_cliente y id_asesor
-- ************************************************************ -- 
SELECT 

DISTINCT(p.id_pedido),p.fecha_pago,p.estado, 
(SELECT SUM(cantidad) FROM  detalle_pedido WHERE detalle_pedido.id_pedido= d.id_pedido) AS total_productos,
(SELECT SUM(total) FROM  detalle_pedido WHERE detalle_pedido.id_pedido= d.id_pedido) AS total_pedido

FROM pedido p INNER JOIN detalle_pedido d 
ON p.id_pedido = d.id_pedido
 WHERE p.id_cliente=1 AND p.id_asesor=3

-- consulta obtener productos de detalle_pedido -- recibe como paremetro id_cliente y id_asesor
-- ************************************************************ -- 

SELECT 

pro.id_producto,pro.tipo, d.cantidad,pro.valor_unitario,d.total

FROM pedido p INNER JOIN detalle_pedido d 
ON p.id_pedido = d.id_pedido INNER JOIN productos pro
ON pro.id_producto = d.id_producto
 WHERE p.id_cliente=1 AND p.id_asesor=3



CALL getAsesors
CALL getClientes(3)
CALL getdetalle(1,3)
CALL getproduct(1,3)
