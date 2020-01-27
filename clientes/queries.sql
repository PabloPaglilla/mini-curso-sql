-- SELECT básico

-- Obtener todos los datos de los clientes
SELECT * FROM clientes;

-- Obtener descripción y precio unitario de todos los productos
SELECT descripcion, precio_unitario FROM productos;

-- ORDER BY

-- Obtener descripcion y precio unitario de todos los productos, ordenados por precio de menor a mayor
SELECT descripcion, precio_unitario FROM productos ORDER BY precio_unitario;
-- Equivalente: SELECT descripcion, precio_unitario FROM productos ORDER BY 2

-- Obtener descripcion y precio unitario de todos los productos, ordenados por precio de mayor a menor
SELECT descripcion, precio_unitario FROM productos ORDER BY precio_unitario DESC;
-- Equivalente: SELECT descripcion, precio_unitario FROM productos ORDER BY 2 DESC

-- WHERE básico

-- Obtener nombre, apellido de los clientes cuya fecha de nacimiento no se conoce
SELECT nombre, apellido FROM clientes WHERE fecha_nacimiento IS NULL;

-- Obtener los datos de todos los productos cuyo stock disponible sea menor a 20
SELECT * FROM productos WHERE cantidad_en_stock < 20;

-- Obtener los datos de todos los productos cuyo precio unitario es mayor o igual a $2000
SELECT * FROM productos WHERE precio_unitario >= 2000;

-- Obtener el stock disponible del metegol
SELECT cantidad_en_stock FROM productos WHERE descripcion = 'Metegol';

-- LIKE

-- Obtener todas las pelotas que vende el local
SELECT * FROM productos WHERE descripcion LIKE 'Pelota%';

-- Operadores lógicos AND y OR

-- Obtener todas las pelotas que vende el local cuyo stock sea menor a 40
SELECT * FROM productos WHERE descripcion LIKE 'Pelota%' AND cantidad_en_stock < 40;

-- Obtener todos los clientes que hayan estudiado en la UTN o en la UBA
SELECT * FROM clientes WHERE universidad = 'UTN' OR universidad = 'UBA';

-- Operador IN

-- Obtener todos los clientes que hayan estudiado en la UTN o en la UBA (ahora usando IN en vez de OR)
SELECT * FROM clientes WHERE universidad IN ('UTN', 'UBA');

-- Operador BETWEEN

-- Obtener todos los productos cuyo precio esté entre 800 y 1500 pesos
SELECT * FROM productos WHERE precio_unitario BETWEEN 800 AND 1500;

-- Obtener todos los clientes que hayan nacido entre 1998 y 2001
SELECT * FROM clientes WHERE fecha_nacimiento BETWEEN '1998-01-01' AND '2001-12-31';

-- NOT (negación)

-- Obtener todos los productos que NO sean pelotas
SELECT * FROM PRODUCTOS WHERE descripcion NOT LIKE 'Pelota%';

-- Obtener todos los clientes que NO hayan estudiado ni en la UTN o ni en la UBA
SELECT * FROM clientes WHERE universidad NOT IN ('UTN', 'UBA');

-- Obtener nombre, apellido y fecha de nacimiento de los clientes cuya fecha de nacimiento se conoce
SELECT nombre, apellido, fecha_nacimiento FROM clientes WHERE fecha_nacimiento IS NOT NULL;

-- DISTINCT

-- Obtener todas las universidades en las cuales estudiaron los clientes
SELECT DISTINCT universidad FROM clientes;
-- Notar la diferencia con ejecutar 'SELECT universidad FROM clientes'

-- Expresiones, alias de columna

-- Obtener el valor del stock de cada producto (precio unitario * cantidad en stock), junto con su descripcion
SELECT descripcion, (precio_unitario * cantidad_en_stock) valor_del_stock FROM productos;