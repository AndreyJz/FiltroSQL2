INSERT INTO clientes (id, nombre, apellidos, celular, direccion, correo_electronico) VALUES
('C001', 'Juan', 'Pérez', 9987654321, 'Calle Falsa 123', 'juan.perez@gmail.com'),
('C002', 'María', 'González', 9976543210, 'Avenida Siempre Viva 456', 'maria.gonzalez@yahoo.com'),
('C003', 'Carlos', 'Ramírez', 9965432109, 'Calle Luna 789', 'carlos.ramirez@hotmail.com'),
('C004', 'Ana', 'López', 9954321098, 'Boulevard of Broken Dreams 012', 'ana.lopez@outlook.com');

INSERT INTO categorias (descripcion, estado) VALUES
('Electrónica', 1),
('Ropa', 1),
('Alimentos', 1),
('Libros', 1);

INSERT INTO productos (nombre, id_categoria, codigo_barras, precio_venta, cantidad_stock, estado) VALUES
('Smartphone Samsung Galaxy S21', 1, '8806090968146', 799.99, 30, 1),
('Pantalones Levis 501', 2, '5400816175975', 59.99, 100, 1),
('Leche Entera La Serenísima 1L', 3, '7790400000346', 1.50, 200, 1),
('Cien Años de Soledad', 4, '9780060883287', 19.99, 50, 1);

INSERT INTO compras (id_cliente, fecha, medio_pago, comentario, estado) VALUES
('C001', '2024-07-25 09:30:00', 'C', 'Compra de smartphone', 'A'),
('C002', '2024-07-26 14:15:00', 'D', 'Compra de pantalones', 'A'),
('C003', '2024-07-27 16:45:00', 'T', 'Compra de leche', 'A'),
('C004', '2024-07-28 11:20:00', 'C', 'Compra de libro', 'A');

INSERT INTO compras_productos (id_compra, id_producto, cantidad, total, estado) VALUES
(1, 1, 1, 799.99, 1),
(2, 2, 2, 119.98, 1),
(3, 3, 10, 15.00, 1),
(4, 4, 1, 19.99, 1);
