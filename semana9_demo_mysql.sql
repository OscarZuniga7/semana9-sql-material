
-- Semana 9 - DEMO MySQL
-- Consultas simples y complejas: SELECT, WHERE, ORDER BY, JOIN, GROUP BY, HAVING
-- Autor: Asistente
-- Dialecto: MySQL 8.x

-- ==== Preparación del entorno ====
DROP DATABASE IF EXISTS semana9_demo;
CREATE DATABASE semana9_demo;
USE semana9_demo;

-- ==== Esquema ====
CREATE TABLE clientes (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  ciudad VARCHAR(100) NOT NULL,
  email VARCHAR(150) UNIQUE
);

CREATE TABLE categorias (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE productos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  categoria_id INT NOT NULL,
  precio DECIMAL(10,2) NOT NULL,
  FOREIGN KEY (categoria_id) REFERENCES categorias(id)
);

CREATE TABLE pedidos (
  id INT AUTO_INCREMENT PRIMARY KEY,
  cliente_id INT NOT NULL,
  fecha DATE NOT NULL,
  FOREIGN KEY (cliente_id) REFERENCES clientes(id)
);

CREATE TABLE detalle_pedido (
  pedido_id INT NOT NULL,
  producto_id INT NOT NULL,
  cantidad INT NOT NULL,
  precio_unitario DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (pedido_id, producto_id),
  FOREIGN KEY (pedido_id) REFERENCES pedidos(id)
    ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (producto_id) REFERENCES productos(id)
);

-- ==== Datos ====
INSERT INTO clientes (nombre, ciudad, email) VALUES
('Juan Pérez', 'Santiago', 'juan.perez@example.com'),
('María López', 'Santiago', 'maria.lopez@example.com'),
('Carlos Díaz', 'Valparaíso', 'carlos.diaz@example.com'),
('Ana Torres', 'Concepción', 'ana.torres@example.com'),
('Lucía Rojas', 'Antofagasta', 'lucia.rojas@example.com'),
('Pedro Morales', 'Santiago', 'pedro.morales@example.com'),
('Elena Silva', 'Valparaíso', 'elena.silva@example.com'),
('Tomás Fuentes', 'Concepción', 'tomas.fuentes@example.com');

INSERT INTO categorias (nombre) VALUES
('Bebidas'),
('Snacks'),
('Lácteos'),
('Aseo'),
('Panadería');

INSERT INTO productos (nombre, categoria_id, precio) VALUES
('Agua 1L', 1, 800.00),
('Jugo Naranja 1L', 1, 1500.00),
('Papas fritas 200g', 2, 1200.00),
('Maní salado 150g', 2, 900.00),
('Leche 1L', 3, 1100.00),
('Yogurt 170g', 3, 600.00),
('Detergente 1kg', 4, 2800.00),
('Cloro 1L', 4, 1200.00),
('Marraqueta (kg)', 5, 1800.00),
('Hallulla (kg)', 5, 1900.00),
('Kuchen manzana', 5, 3500.00),
('Pan molde', 5, 2300.00);

-- Pedidos (12)
INSERT INTO pedidos (cliente_id, fecha) VALUES
(1, '2025-07-01'),
(2, '2025-07-02'),
(3, '2025-07-03'),
(1, '2025-07-05'),
(4, '2025-07-05'),
(5, '2025-07-06'),
(6, '2025-07-07'),
(3, '2025-07-10'),
(2, '2025-07-11'),
(7, '2025-07-12'),
(8, '2025-07-15'),
(1, '2025-08-01');

-- Detalle de pedidos
INSERT INTO detalle_pedido (pedido_id, producto_id, cantidad, precio_unitario) VALUES
-- Pedido 1
(1, 1, 3, 800.00),
(1, 3, 2, 1200.00),
(1, 5, 1, 1100.00),
-- Pedido 2
(2, 2, 1, 1500.00),
(2, 4, 3, 900.00),
-- Pedido 3
(3, 7, 1, 2800.00),
(3, 8, 2, 1200.00),
-- Pedido 4
(4, 9, 2, 1800.00),
(4, 11, 1, 3500.00),
-- Pedido 5
(5, 6, 6, 600.00),
(5, 5, 2, 1100.00),
-- Pedido 6
(6, 7, 2, 2800.00),
(6, 12, 1, 2300.00),
-- Pedido 7
(7, 10, 1, 1900.00),
(7, 6, 4, 600.00),
-- Pedido 8
(8, 2, 2, 1500.00),
(8, 3, 2, 1200.00),
(8, 4, 2, 900.00),
-- Pedido 9
(9, 1, 1, 800.00),
(9, 5, 2, 1100.00),
-- Pedido 10
(10, 8, 3, 1200.00),
(10, 3, 1, 1200.00),
-- Pedido 11
(11, 9, 1, 1800.00),
(11, 2, 1, 1500.00),
-- Pedido 12
(12, 11, 2, 3500.00),
(12, 1, 2, 800.00);

-- ==== ÍNDICES sugeridos para consultas ====
CREATE INDEX idx_pedidos_cliente_fecha ON pedidos (cliente_id, fecha);
CREATE INDEX idx_detalle_producto ON detalle_pedido (producto_id);
CREATE INDEX idx_productos_categoria ON productos (categoria_id);

-- ==== EJERCICIOS ====
-- 1) Consultas simples: proyección, alias, expresiones, filtros.
-- a) Listar nombre y ciudad de todos los clientes ordenados alfabéticamente.
-- b) Mostrar producto, precio y precio con IVA 19% (alias 'precio_iva').
-- c) Clientes de Santiago o Valparaíso.
-- d) Productos con precio entre 1000 y 2000 inclusive.
-- e) Buscar clientes cuyo nombre contiene 'a' (case-insensitive según colación).

-- 2) JOINs: INNER, LEFT, RIGHT (nota: MySQL no soporta FULL OUTER JOIN nativo).
-- a) Listar pedidos con nombre del cliente y fecha (INNER JOIN).
-- b) Listar todos los clientes y, si tienen, su último pedido (LEFT JOIN + MAX por cliente).
-- c) Productos y su categoría (INNER JOIN).

-- 3) LEFT JOIN para "no relacionados":
-- a) Clientes que no han realizado pedidos.
-- b) Categorías sin productos.

-- 4) Agregaciones y GROUP BY / HAVING
-- a) Total gastado por pedido (sum(cantidad*precio_unitario)).
-- b) Top 5 clientes por monto total.
-- c) Ventas por categoría (monto y cantidad de ítems).
-- d) Productos con ventas totales > 5000 (HAVING).

-- 5) Consultas con múltiples JOINs
-- a) Ventas por ciudad y categoría.
-- b) Producto más vendido por cantidad total (top 1).

-- 6) Bonus
-- a) Clientes con su primer y último pedido (MIN(fecha), MAX(fecha)).
-- b) Pedidos del último mes (relativo a CURDATE()).

-- ==== PLANTILLAS DE SOLUCIÓN ====

-- 1.a
-- SELECT nombre, ciudad FROM clientes ORDER BY nombre;

-- 1.b
-- SELECT nombre AS producto, precio, ROUND(precio*1.19, 2) AS precio_iva
-- FROM productos ORDER BY precio DESC;

-- 1.c
-- SELECT * FROM clientes WHERE ciudad IN ('Santiago', 'Valparaíso');

-- 1.d
-- SELECT * FROM productos WHERE precio BETWEEN 1000 AND 2000;

-- 1.e
-- SELECT * FROM clientes WHERE nombre LIKE '%a%';

-- 2.a
-- SELECT p.id AS pedido_id, c.nombre AS cliente, p.fecha
-- FROM pedidos p
-- INNER JOIN clientes c ON c.id = p.cliente_id
-- ORDER BY p.fecha;

-- 2.b (LEFT JOIN + subconsulta para último pedido por cliente)
-- SELECT c.id, c.nombre, up.ultima_fecha
-- FROM clientes c
-- LEFT JOIN (
--   SELECT cliente_id, MAX(fecha) AS ultima_fecha
--   FROM pedidos GROUP BY cliente_id
-- ) up ON up.cliente_id = c.id
-- ORDER BY c.nombre;

-- 2.c
-- SELECT pr.nombre AS producto, ca.nombre AS categoria, pr.precio
-- FROM productos pr
-- INNER JOIN categorias ca ON ca.id = pr.categoria_id
-- ORDER BY ca.nombre, pr.nombre;

-- 3.a
-- SELECT c.*
-- FROM clientes c
-- LEFT JOIN pedidos p ON p.cliente_id = c.id
-- WHERE p.id IS NULL;

-- 3.b
-- SELECT ca.*
-- FROM categorias ca
-- LEFT JOIN productos pr ON pr.categoria_id = ca.id
-- WHERE pr.id IS NULL;

-- 4.a
-- SELECT dp.pedido_id,
--        SUM(dp.cantidad * dp.precio_unitario) AS total_pedido
-- FROM detalle_pedido dp
-- GROUP BY dp.pedido_id
-- ORDER BY total_pedido DESC;

-- 4.b (top 5 por monto total)
-- SELECT c.id, c.nombre,
--        SUM(dp.cantidad * dp.precio_unitario) AS total
-- FROM clientes c
-- JOIN pedidos p ON p.cliente_id = c.id
-- JOIN detalle_pedido dp ON dp.pedido_id = p.id
-- GROUP BY c.id, c.nombre
-- ORDER BY total DESC
-- LIMIT 5;

-- 4.c
-- SELECT ca.nombre AS categoria,
--        SUM(dp.cantidad * dp.precio_unitario) AS monto,
--        SUM(dp.cantidad) AS items
-- FROM categorias ca
-- JOIN productos pr ON pr.categoria_id = ca.id
-- JOIN detalle_pedido dp ON dp.producto_id = pr.id
-- GROUP BY ca.nombre
-- ORDER BY monto DESC;

-- 4.d
-- SELECT pr.id, pr.nombre,
--        SUM(dp.cantidad * dp.precio_unitario) AS total_ventas
-- FROM productos pr
-- JOIN detalle_pedido dp ON dp.producto_id = pr.id
-- GROUP BY pr.id, pr.nombre
-- HAVING total_ventas > 5000
-- ORDER BY total_ventas DESC;

-- 5.a
-- SELECT c.ciudad, ca.nombre AS categoria,
--        SUM(dp.cantidad * dp.precio_unitario) AS monto
-- FROM clientes c
-- JOIN pedidos p ON p.cliente_id = c.id
-- JOIN detalle_pedido dp ON dp.pedido_id = p.id
-- JOIN productos pr ON pr.id = dp.producto_id
-- JOIN categorias ca ON ca.id = pr.categoria_id
-- GROUP BY c.ciudad, ca.nombre
-- ORDER BY c.ciudad, monto DESC;

-- 5.b (producto más vendido por cantidad)
-- SELECT pr.id, pr.nombre, SUM(dp.cantidad) AS total_cant
-- FROM productos pr
-- JOIN detalle_pedido dp ON dp.producto_id = pr.id
-- GROUP BY pr.id, pr.nombre
-- ORDER BY total_cant DESC
-- LIMIT 1;

-- 6.a
-- SELECT c.id, c.nombre,
--        MIN(p.fecha) AS primer_pedido,
--        MAX(p.fecha) AS ultimo_pedido
-- FROM clientes c
-- LEFT JOIN pedidos p ON p.cliente_id = c.id
-- GROUP BY c.id, c.nombre;

-- 6.b
-- SELECT p.*
-- FROM pedidos p
-- WHERE p.fecha >= DATE_SUB(CURDATE(), INTERVAL 30 DAY)
-- ORDER BY p.fecha DESC;

-- ¡Éxitos en la práctica!
