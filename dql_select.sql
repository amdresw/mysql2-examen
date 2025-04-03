SELECT p.id_pelicula, p.titulo, i.id_almacen
FROM pelicula p
JOIN inventario i ON p.id_pelicula = i.id_pelicula
WHERE i.id_almacen = 1; -- Cambiar el número por el ID del almacén que se necesite

SELECT c.id_cliente, c.nombre, c.apellidos, COUNT(a.id_alquiler) AS total_alquileres
FROM cliente c
JOIN alquiler a ON c.id_cliente = a.id_cliente
GROUP BY c.id_cliente
ORDER BY total_alquileres DESC
LIMIT 10; 

SELECT e.id_empleado, e.nombre, e.apellidos, SUM(p.total) AS ingresos_totales
FROM empleado e
JOIN pago p ON e.id_empleado = p.id_empleado
GROUP BY e.id_empleado
ORDER BY ingresos_totales DESC;

SELECT p.id_pelicula, p.titulo, COUNT(a.id_alquiler) AS veces_alquilada
FROM pelicula p
JOIN inventario i ON p.id_pelicula = i.id_pelicula
JOIN alquiler a ON i.id_inventario = a.id_inventario
GROUP BY p.id_pelicula
ORDER BY veces_alquilada DESC
LIMIT 10;

SELECT c.id_cliente, c.nombre, c.apellidos, a.id_alquiler, a.fecha_alquiler
FROM cliente c
JOIN alquiler a ON c.id_cliente = a.id_cliente
LEFT JOIN pago p ON a.id_alquiler = p.id_alquiler
WHERE p.id_pago IS NULL; -- Clientes que alquilaron pero no han pagado
