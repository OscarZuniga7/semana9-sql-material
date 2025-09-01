-- ==============================
-- Semana 11 — Vistas seguras (MySQL) para 'semana9_demo'
-- Suposición mínima (validada en el sitio): existe tabla `clientes`.
-- ==============================

DROP VIEW IF EXISTS v_clientes_all;
DROP VIEW IF EXISTS v_clientes_top10;
DROP VIEW IF EXISTS v_clientes_total;

-- 1) Vista directa a la tabla (útil para permisos / desacoplar SELECT * FROM)
CREATE VIEW v_clientes_all AS
SELECT * FROM clientes;

-- 2) Vista top 10 filas (muestra rápida)
CREATE VIEW v_clientes_top10 AS
SELECT * FROM clientes LIMIT 10;

-- 3) Vista resumen con total de filas
CREATE VIEW v_clientes_total AS
SELECT COUNT(*) AS total_clientes FROM clientes;