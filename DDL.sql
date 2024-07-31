DROP DATABASE IF EXISTS miscompras;
CREATE DATABASE miscompras;

USE miscompras;

CREATE TABLE clientes (
    id VARCHAR(20),
    nombre VARCHAR(40) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    celular DECIMAL(10, 0),
    direccion VARCHAR(80),
    correo_electronico VARCHAR(70),
    CONSTRAINT pk_clientes_id PRIMARY KEY (id)
);

CREATE TABLE categorias (
    id INT AUTO_INCREMENT,
    descripcion VARCHAR(45),
    estado TINYINT,
    CONSTRAINT pk_categorias_id PRIMARY KEY (id)
);

CREATE TABLE productos (
    id INT AUTO_INCREMENT,
    nombre VARCHAR(45) NOT NULL,
    id_categoria INT,
    codigo_barras VARCHAR(150),
    precio_venta DECIMAL(16, 2),
    cantidad_stock INT,
    estado TINYINT,
    CONSTRAINT pk_productos_id PRIMARY KEY (id),
    CONSTRAINT fk_productos_categorias_categoria_id FOREIGN KEY (id_categoria) REFERENCES categorias(id)
);

CREATE TABLE compras (
    id INT AUTO_INCREMENT,
    id_cliente VARCHAR(20),
    fecha DATETIME,
    medio_pago CHAR(1),
    comentario VARCHAR(300),
    estado CHAR(1),
    CONSTRAINT pk_compras_id PRIMARY KEY (id),
    CONSTRAINT fk_compras_clientes_cliente_id FOREIGN KEY (id_cliente) REFERENCES clientes(id)
);

CREATE TABLE compras_productos (
    id_compra INT,
    id_producto INT,
    cantidad DECIMAL(16, 2),
    total DECIMAL(16, 2),
    estado TINYINT,
    PRIMARY KEY (id_compra, id_producto),
    CONSTRAINT fk_compras_productos_compras_compra_id FOREIGN KEY (id_compra) REFERENCES compras(id),
    CONSTRAINT fk_compras_productos_productos_producto_id FOREIGN KEY (id_producto) REFERENCES productos(id)
);
