# MisCompras DB

![img](https://cdn.discordapp.com/attachments/763109827748429876/1268231126523056210/image.png?ex=66ababc7&is=66aa5a47&hm=763e79dd17fe6b7746d51baafba5246b2e7aa74d7dfba2963335738a02fb6c65&)

## Consultas Básicas

#### Consultar todos los productos y sus categorías

```sql
SELECT p.id, p.nombre, c.descripcion as categoria, p.codigo_barras, p.precio_venta, p.cantidad_stock, p.estado
FROM productos p
JOIN categorias c ON p.id_categoria = c.id;
```



#### Consultar todas las compras y los clientes que las realizaron

```sql
SELECT co.id, co.fecha, co.medio_pago, co.comentario, co.estado, cli.id as cliente_id, cli.nombre, cli.apellidos
FROM compras co
JOIN clientes cli ON co.id_cliente = cli.id;
```



#### Consultar los productos comprados en una compra específica

```sql
SELECT p.id, p.nombre, c.id as venta_id
FROM compras_productos cp
JOIN productos p ON cp.id_producto = p.id
JOIN compras c ON cp.id_compra = c.id
WHERE c.id = 1;
```



#### Agregar un nuevo producto

```sql
INSERT INTO productos (nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado) VALUES
('iPhone 16', 1, '1806090968148', 200.00, 10, 1);
```



#### Actualizar el stock de un producto

```sql
UPDATE productos p
SET p.cantidad_stock = 20
WHERE p.id = 5;
```



#### Consultar todas las compras de un cliente específico

```sql
SELECT co.id, co.id_cliente, co.fecha, co.medio_pago, co.comentario, co.estado
FROM compras co
WHERE co.id_cliente = 'C001';
```



#### Consultar todos los clientes y sus correos electrónicos

```sql
SELECT c.id, c.nombre, c.apellidos, c.correo_electronico
FROM clientes c;
```



#### Consultar la cantidad total de productos comprados en cada compra

```sql
SELECT cp.id as compraID, SUM(cp.cantidad) as cantidadProductos
FROM compras_productos cp;
```



#### Consultar las compras realizadas en un rango de fechas

```sql
SELECT c.id as compraID, c.fecha
FROM compras c
WHERE c.fecha BETWEEN '2024-07-20' AND '2024-07-31';
```



## Consultas usando funciones agregadas

#### Contar la cantidad de productos por categoría
```sql
SELECT p.id_categoria, COUNT(p.cantidad_stock)
FROM productos p
GROUP BY p.id_categoria;
```
#### Calcular el precio total de ventas por cada cliente
```sql
SELECT c.id_cliente, SUM(cp.total) as totalCompras
FROM compras c
JOIN compras_productos cp ON cp.id_compra = c.id
GROUP BY c.id_cliente;
```
#### Calcular el precio promedio de los productos por categoría
```sql
SELECT p.id_categoria, AVG(p.precio_venta) as Promedio
FROM productos p
GROUP BY p.id_categoria;
```
#### Encontrar la fecha de la primera y última compra registrada
```sql
SELECT MAX(c.fecha) as PrimeraFecha, MIN(c.fecha) as UltimaFecha
FROM compras c;
```
#### Calcular el total de ingresos por ventas
```sql
SELECT cp.id_compra, SUM(cp.total) as totalIngresos
FROM compras_productos cp
GROUP BY cp.id_compra;
```
#### Contar la cantidad de compras realizadas por cada medio de pago
```sql
SELECT c.medio_pago, COUNT(c.id) as cantidadCompras
FROM compras c
GROUP BY c.medio_pago;
```
#### Calcular el total de productos vendidos por cada producto
```sql
SELECT cp.id_producto, SUM(cp.cantidad) as cantidadVendido
FROM compras_productos cp
GROUP BY cp.id_producto;
```
#### Obtener el promedio de cantidad de productos comprados por compra
```sql
SELECT cp.id_compra, AVG(cp.cantidad) as cantidadComprada
FROM compras_productos cp
GROUP BY cp.id_compra;
```
#### Encontrar los productos con el stock más bajo
```sql
SELECT p.id, p.nombre, p.cantidad_stock
FROM productos p
WHERE p.cantidad_stock = (
    SELECT MIN(cantidad_stock)
    FROM productos
);
```
#### Calcular el total de productos comprados y el total gastado por cliente
```sql
SELECT c.id as clienteID, SUM(cp.cantidad) as cantitdadComprada, SUM(cp.total) as totalGastado
FROM compras_productos cp
JOIN compras c On cp.id_compra = c.id
GROUP BY c.id;
```

## Consultas usando join

#### Consultar todos los productos con sus categorías
```sql
SELECT p.id, p.nombre, c.descripcion as categoria, p.codigo_barras, p.precio_venta, p.cantidad_stock, p.estado
FROM productos p
JOIN categorias c ON p.id_categoria = c.id;
```

#### Consultar todas las compras y los clientes que las realizaron
```sql
SELECT co.id, co.fecha, co.medio_pago, co.comentario, co.estado, cli.id as cliente_id, cli.nombre, cli.apellidos
FROM compras co
JOIN clientes cli ON co.id_cliente = cli.id;
```

#### Consultar los productos comprados en cada compra
```sql
SELECT p.id, p.nombre, c.id as venta_id
FROM compras_productos cp
JOIN productos p ON cp.id_producto = p.id
JOIN compras c ON cp.id_compra = c.id;
```

#### Consultar las compras realizadas por un cliente específico
```sql
SELECT co.id, co.fecha, co.medio_pago, co.comentario, co.estado, cli.id, cli.nombre, cli.apellidos
FROM compras co
JOIN clientes cli ON co.id_cliente = cli.id
WHERE cli.id = 'C001';
```

#### Consultar el total gastado por cada cliente
```sql
SELECT c.id as clienteID, SUM(cp.total) as totalGastado
FROM compras_productos cp
JOIN compras c On cp.id_compra = c.id
GROUP BY c.id;
```

#### Consultar el stock disponible de productos y su categoría
```sql
SELECT p.id as productoID, p.cantidad_stock, c.descripcion
FROM productos p
JOIN categorias c ON c.id = p.id_categoria;
```

#### Consultar los detalles de compras junto con la información del cliente y el producto
```sql
SELECT c.id as compraID, c.fecha, c.medio_pago, c.comentario, c.estado, p.id as productoID, p.nombre, p.id_categoria, p.precio_venta, cli.id as clienteID, cli.nombre, cli.apellidos, cli.correo_electronico
FROM compras_productos cp
JOIN compras c ON cp.id_compra = c.id
JOIN productos p ON p.id = cp.id_producto
JOIN clientes cli ON cli.id = c.id_cliente;
```

#### Consultar los productos que han sido comprados por más de una cantidad específica
```sql
SELECT cp.id_producto as productoID, cp.cantidad
FROM compras_productos cp
WHERE cp.cantidad > 1;
```

#### Consultar la cantidad total de productos vendidos por categoría
```sql
SELECT p.id_categoria, SUM(cp.cantidad) as total
FROM productos p
JOIN compras_productos cp ON p.id = cp.id_producto
GROUP BY p.id_categoria;
```

#### Consultar los clientes que han realizado compras en un rango de fechas específico
```sql
SELECT cli.id as clienteID, c.fecha
FROM compras c
JOIN clientes cli ON cli.id = c.id_cliente
WHERE c.fecha BETWEEN '2024-07-26' AND '2024-07-31';
```

#### Consultar el total gastado por cada cliente junto con la cantidad total de productos comprados
```sql
SELECT c.id as clienteID, SUM(cp.cantidad) as cantitdadComprada, SUM(cp.total) as totalGastado
FROM compras_productos cp
JOIN compras c On cp.id_compra = c.id
GROUP BY c.id;
```

#### Consultar los productos que nunca han sido comprados
```sql
SELECT p.id, p.nombre
FROM productos p
LEFT JOIN compras_productos cp ON p.id = cp.id_producto
WHERE cp.id_producto IS NULL;
```

#### Consultar los clientes que han realizado más de una compra y el total gastado por ellos
```sql
SELECT c.id as clienteID, COUNT(c.id_cliente), SUM(cp.total) as totalGastado
FROM compras_productos cp
JOIN compras c On cp.id_compra = c.id
GROUP BY c.id
HAVING COUNT(c.id_cliente) > 1;
```

#### Consultar los productos más vendidos por categoría
```sql
SELECT c.descripcion AS Categoria, SUM(cantidad) AS cantidad
FROM compras_productos cp
JOIN productos P ON p.id = cp.id_producto
JOIN categorias c ON c.id = p.id_categoria
GROUP BY c.descripcion
ORDER BY cantidad DESC;
```

#### Consultar las compras realizadas por clientes de una ciudad específica y el total gastado
```sql
-- lo hago por direccion porque no hay ciudad

SELECT c.id, cli.direccion
FROM compras c
JOIN clientes cli ON c.id_cliente = cli.id
WHERE cli.direccion LIKE '%Boulevard%';
```




## Subconsultas

#### Consultar los productos que tienen un precio de venta superior al precio promedio de todos los productos
```sql
SELECT p.id, p.nombre, p.precio_venta
FROM productos p
WHERE p.precio_venta > (
    SELECT AVG(precio_venta)
    FROM productos
);
```

#### Consultar los clientes que han gastado más del promedio general en sus compras
```sql
SELECT cli.id as clienteID, cli.nombre, cp.total
FROM compras_productos cp
JOIN compras c ON cp.id_compra = c.id
JOIN clientes cli ON cli.id = c.id_cliente
WHERE cp.total > (
    SELECT AVG(cp.total)
    FROM compras_productos cp
    JOIN compras c ON cp.id_compra = c.id
    JOIN clientes clisub ON clisub.id = c.id_cliente
);
```

#### Consultar las categorías que tienen más de 5 productos
```sql
SELECT id, descripcion 
FROM categorias 
WHERE id_categoria IN (
    SELECT id_categoria 
    FROM productos 
    GROUP BY id_categoria 
    HAVING COUNT(id_producto) > 5);
```

#### Consultar los productos más vendidos (top 5) por categoría
```sql
SELECT p.id_categoria, p.nombre, 
       (SELECT SUM(cantidad)
        FROM compras_productos cp
        WHERE cp.id_producto = p.id) as total_vendido
FROM productos p
WHERE p.id_categoria = 1
GROUP BY p.id_categoria, p.id
ORDER BY p.id_categoria, total_vendido DESC
LIMIT 5;
```

#### Consultar los clientes que han realizado compras en los últimos 30 días
```sql
SELECT c.id, c.nombre
FROM clientes c
WHERE c.id IN (
    SELECT co.id_cliente
    FROM compras co
    WHERE TIMESTAMPDIFF(MONTH, co.fecha, CURDATE()) = 0
);
```

#### Consultar las compras y sus productos para un cliente específico, mostrando solo las compras más recientes
```sql
SELECT cli.id, cli.nombre, p.id, p.nombre, c.id
FROM compras c
JOIN compras_productos cp ON c.id = cp.id_compra
JOIN clientes cli ON c.id_cliente = cli.id
JOIN productos p ON p.id = cp.id_producto
WHERE c.id IN (
    SELECT c.id
    FROM compras
    WHERE c.id_cliente = 'C001'
)
ORDER BY c.fecha DESC;
```

#### Consultar las categorías que tienen productos con un stock por debajo del promedio general
```sql

```

#### Consultar los productos que han sido comprados por todos los clientes
```sql

```

#### Consultar las compras que tienen más productos que el promedio de productos por compra
```sql

```

#### Consultar los productos que se han vendido menos de la cantidad promedio de productos vendidos
```sql

```
