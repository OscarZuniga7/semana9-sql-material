-- ==============================
-- Semana 11 — Vistas seguras (SQLite) para 'semana9_demo'
-- Suposición mínima (validada en el sitio): existe tabla `clientes`.
-- ==============================

DROP VIEW IF EXISTS v_clientes_all;
DROP VIEW IF EXISTS v_clientes_top10;
DROP VIEW IF EXISTS v_clientes_total;

CREATE VIEW v_clientes_all AS
SELECT * FROM clientes;

CREATE VIEW v_clientes_top10 AS
SELECT * FROM clientes LIMIT 10;

CREATE VIEW v_clientes_total AS
SELECT COUNT(*) AS total_clientes FROM clientes;