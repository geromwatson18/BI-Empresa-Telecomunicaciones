/* ============================================================
   PROYECTO BI - GRUPO 5
   BASE TRANSACCIONAL + DATOS MASIVOS
============================================================ */

------------------------------------------------------------
-- 1. CREAR BASE DE DATOS
------------------------------------------------------------
IF DB_ID('telecom_operacional') IS NOT NULL
    DROP DATABASE telecom_operacional;
GO

CREATE DATABASE telecom_operacional;
GO

USE telecom_operacional;
GO

------------------------------------------------------------
-- 2. CREAR TABLAS
------------------------------------------------------------

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY,
    codigo_cliente VARCHAR(20),
    tipo_cliente VARCHAR(20),
    edad INT,
    sexo VARCHAR(10),
    perfil_consumo VARCHAR(10),
    fecha_registro DATE,
    estado VARCHAR(10)
);

CREATE TABLE plan (
    id_plan INT PRIMARY KEY,
    nombre_plan VARCHAR(50),
    tipo_plan VARCHAR(20),
    precio DECIMAL(10,2)
);

CREATE TABLE tienda (
    id_tienda INT PRIMARY KEY,
    nombre_tienda VARCHAR(50),
    tipo_tienda VARCHAR(20),
    region VARCHAR(50)
);

CREATE TABLE contrato (
    id_contrato INT PRIMARY KEY,
    id_cliente INT,
    id_plan INT,
    fecha_inicio DATE,
    fecha_fin DATE,
    estado VARCHAR(10),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_plan) REFERENCES plan(id_plan)
);

CREATE TABLE venta (
    id_venta INT PRIMARY KEY,
    id_cliente INT,
    id_plan INT,
    id_tienda INT,
    fecha_venta DATETIME,
    monto DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_plan) REFERENCES plan(id_plan),
    FOREIGN KEY (id_tienda) REFERENCES tienda(id_tienda)
);

CREATE TABLE averia (
    id_averia INT PRIMARY KEY,
    id_cliente INT,
    tipo_problema VARCHAR(50),
    es_controlable VARCHAR(10),
    fecha_reporte DATETIME,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

------------------------------------------------------------
-- 3. DATOS MAESTROS
------------------------------------------------------------

INSERT INTO plan VALUES
(1, 'Plan Básico', 'Postpago', 15000),
(2, 'Plan Plus', 'Postpago', 25000),
(3, 'Plan Ultra 5G', 'Postpago', 40000),
(4, 'Prepago Diario', 'Prepago', 500);

INSERT INTO tienda VALUES
(1, 'San José Centro', 'Física', 'Central'),
(2, 'Alajuela', 'Física', 'Occidente'),
(3, 'Web', 'Virtual', 'Nacional'),
(4, 'Call Center', 'Virtual', 'Nacional');

------------------------------------------------------------
-- 4. GENERAR CLIENTES (1000)
------------------------------------------------------------

WITH seq AS (
    SELECT TOP 1000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a CROSS JOIN sys.objects b
)
INSERT INTO cliente
SELECT
    n,
    CONCAT('CLI-', FORMAT(n, '00000')),
    CASE WHEN ABS(CHECKSUM(NEWID())) % 100 < 80 THEN 'Residencial' ELSE 'Corporativo' END,
    18 + ABS(CHECKSUM(NEWID())) % 60,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 2 = 0 THEN 'Masculino' ELSE 'Femenino' END,
    CASE 
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 30 THEN 'Alto'
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 70 THEN 'Medio'
        ELSE 'Bajo'
    END,
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 1500, GETDATE()),
    'Activo'
FROM seq;

------------------------------------------------------------
-- 5. GENERAR CONTRATOS
------------------------------------------------------------

INSERT INTO contrato
SELECT
    id_cliente,
    id_cliente,
    1 + ABS(CHECKSUM(NEWID())) % 4,
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 1000, GETDATE()),
    NULL,
    'Activo'
FROM cliente;

------------------------------------------------------------
-- 6. GENERAR AVERÍAS (3000)
------------------------------------------------------------

WITH seq AS (
    SELECT TOP 3000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a CROSS JOIN sys.objects b
)
INSERT INTO averia
SELECT
    n,
    1 + ABS(CHECKSUM(NEWID())) % 1000,
    CASE 
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 40 THEN 'Internet lento'
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 70 THEN 'Sin señal'
        ELSE 'Caída total'
    END,
    CASE WHEN ABS(CHECKSUM(NEWID())) % 100 < 60 THEN 'Sí' ELSE 'No' END,
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE())
FROM seq;

------------------------------------------------------------
-- 7. GENERAR CHURN (clientes inactivos)
------------------------------------------------------------

UPDATE c
SET estado = 'Inactivo'
FROM cliente c
JOIN (
    SELECT id_cliente, COUNT(*) AS total_averias
    FROM averia
    GROUP BY id_cliente
) a ON c.id_cliente = a.id_cliente
WHERE a.total_averias >= 5
AND ABS(CHECKSUM(NEWID())) % 100 < 70;

------------------------------------------------------------
-- 8. GENERAR VENTAS (2000)
------------------------------------------------------------

WITH seq AS (
    SELECT TOP 2000 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
    FROM sys.objects a CROSS JOIN sys.objects b
)
INSERT INTO venta
SELECT
    n,
    1 + ABS(CHECKSUM(NEWID())) % 1000,
    CASE 
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 40 THEN 1
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 70 THEN 2
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 90 THEN 3
        ELSE 4
    END,
    CASE 
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 50 THEN 3
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 70 THEN 4
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 85 THEN 1
        ELSE 2
    END,
    DATEADD(DAY, -ABS(CHECKSUM(NEWID())) % 365, GETDATE()),
    CASE 
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 40 THEN 15000
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 70 THEN 25000
        WHEN ABS(CHECKSUM(NEWID())) % 100 < 90 THEN 40000
        ELSE 500
    END
FROM seq;

------------------------------------------------------------
-- 9. VALIDACIONES
------------------------------------------------------------

SELECT COUNT(*) AS total_clientes FROM cliente;
SELECT COUNT(*) AS total_ventas FROM venta;
SELECT COUNT(*) AS total_averias FROM averia;
SELECT estado, COUNT(*) FROM cliente GROUP BY estado;