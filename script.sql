-- =========================================================================
-- PROYECTO RETAIL - Pre-entrega Coderhouse
-- =========================================================================

-- 1. DDL - Estructura de Tablas
CREATE TABLE clientes (
    cliente_id SERIAL PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellido VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(25),
    fecha_registro DATE DEFAULT CURRENT_DATE,
    edad INT CHECK (edad >= 18) -- RESTRICCIÓN CHECK 1: Edad mínima 18 años
);

CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    nombre_producto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50) NOT NULL,
    precio DECIMAL(10, 2) CHECK (precio > 0), -- RESTRICCIÓN CHECK 2: Precio mayor a 0
    stock INT CHECK (stock >= 0) -- RESTRICCIÓN CHECK 3: Stock no negativo
);

CREATE TABLE ventas (
    venta_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT CHECK (cantidad > 0), -- RESTRICCIÓN CHECK 4: Cantidad mayor a 0
    fecha_venta TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    total_venta DECIMAL(10, 2) NOT NULL,
    CONSTRAINT fk_cliente FOREIGN KEY (cliente_id) REFERENCES clientes(cliente_id),
    CONSTRAINT fk_producto FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);


-- =========================================================================
-- 2. DML - Carga Inicial de Datos (Transacción explícita)
-- =========================================================================

BEGIN;

-- 5 Registros en la tabla clientes
INSERT INTO clientes (nombre, apellido, email, telefono, edad) VALUES
('Juan', 'Pérez', 'juan.perez@email.com', '1122334455', 28),
('María', 'Gómez', 'maria.gomez@email.com', '1155443322', 34),
('Carlos', 'López', 'carlos.lopez@email.com', '1199887766', 42),
('Ana', 'Martínez', 'ana.martinez@email.com', '1133221144', 25),
('Esteban', 'Quito', 'esteban.q@email.com', '1166778899', 31);

-- 5 Registros en la tabla productos
INSERT INTO productos (nombre_producto, categoria, precio, stock) VALUES
('Yerba Mate 1kg', 'Almacén', 3500.00, 150),
('Fideos 500g', 'Almacén', 1200.50, 200),
('Aceite de Girasol 1.5L', 'Almacén', 2800.00, 80),
('Leche Entera 1L', 'Lácteos', 1400.00, 120),
('Queso Cremoso 500g', 'Lácteos', 4500.75, 45);

-- 5 Registros en la tabla ventas
INSERT INTO ventas (cliente_id, producto_id, cantidad, total_venta) VALUES
(1, 1, 2, 7000.00),
(2, 3, 1, 2800.00),
(3, 5, 2, 9001.50),
(4, 2, 4, 4802.00),
(5, 4, 3, 4200.00);

COMMIT;


-- =========================================================================
-- 3. DML - Mantenimiento (UPDATE y DELETE con WHERE seguro)
-- =========================================================================

-- Verificación previa del UPDATE
SELECT producto_id, nombre_producto, precio FROM productos WHERE categoria = 'Almacén';

-- UPDATE masivo: Incrementamos un 10% el precio de los productos de 'Almacén'
UPDATE productos 
SET precio = precio * 1.10 
WHERE categoria = 'Almacén';

-- Verificación previa del DELETE
SELECT * FROM ventas WHERE venta_id = 5;

-- DELETE de un registro específico de prueba
DELETE FROM ventas 
WHERE venta_id = 5;