USE telecom_dw;
GO

/* Limpieza previa */
DELETE FROM fact_averias;
DELETE FROM fact_ventas;
DELETE FROM dim_tiempo;
DELETE FROM dim_averia;
DELETE FROM dim_tienda;
DELETE FROM dim_plan;
DELETE FROM dim_cliente;
GO

/* ========= dim_cliente ========= */
WITH contrato_base AS (
    SELECT
        c.id_cliente,
        MIN(ct.fecha_inicio) AS fecha_inicio_cliente
    FROM telecom_operacional.dbo.cliente c
    LEFT JOIN telecom_operacional.dbo.contrato ct
        ON c.id_cliente = ct.id_cliente
    GROUP BY c.id_cliente
)
INSERT INTO dim_cliente (
    id_cliente, codigo_cliente, tipo_cliente, edad, rango_edad, sexo,
    perfil_consumo, fecha_registro, estado_cliente, antiguedad_meses, segmento_antiguedad
)
SELECT
    c.id_cliente,
    c.codigo_cliente,
    c.tipo_cliente,
    c.edad,
    CASE
        WHEN c.edad BETWEEN 18 AND 25 THEN '18-25'
        WHEN c.edad BETWEEN 26 AND 35 THEN '26-35'
        WHEN c.edad BETWEEN 36 AND 50 THEN '36-50'
        ELSE '51+'
    END,
    c.sexo,
    c.perfil_consumo,
    c.fecha_registro,
    c.estado,
    DATEDIFF(MONTH, COALESCE(cb.fecha_inicio_cliente, c.fecha_registro), GETDATE()) AS antiguedad_meses,
    CASE
        WHEN DATEDIFF(MONTH, COALESCE(cb.fecha_inicio_cliente, c.fecha_registro), GETDATE()) <= 6 THEN 'Nuevo (0-6)'
        WHEN DATEDIFF(MONTH, COALESCE(cb.fecha_inicio_cliente, c.fecha_registro), GETDATE()) <= 24 THEN 'Medio (7-24)'
        ELSE 'Antiguo (25+)'
    END AS segmento_antiguedad
FROM telecom_operacional.dbo.cliente c
LEFT JOIN contrato_base cb
    ON c.id_cliente = cb.id_cliente;
GO

/* ========= dim_plan ========= */
INSERT INTO dim_plan (id_plan, nombre_plan, tipo_plan, precio)
SELECT
    id_plan,
    nombre_plan,
    tipo_plan,
    precio
FROM telecom_operacional.dbo.[plan];
GO

/* ========= dim_tienda ========= */
INSERT INTO dim_tienda (id_tienda, nombre_tienda, tipo_tienda, region)
SELECT
    id_tienda,
    nombre_tienda,
    tipo_tienda,
    region
FROM telecom_operacional.dbo.tienda;
GO

/* ========= dim_averia ========= */
INSERT INTO dim_averia (tipo_problema, es_controlable)
SELECT DISTINCT
    tipo_problema,
    es_controlable
FROM telecom_operacional.dbo.averia;
GO

/* ========= dim_tiempo ========= */
INSERT INTO dim_tiempo (fecha, dia, mes, nombre_mes, trimestre, anio)
SELECT DISTINCT
    CAST(f.fecha_evento AS DATE) AS fecha,
    DAY(f.fecha_evento) AS dia,
    MONTH(f.fecha_evento) AS mes,
    CAST(
        CASE MONTH(f.fecha_evento)
            WHEN 1 THEN 'January'
            WHEN 2 THEN 'February'
            WHEN 3 THEN 'March'
            WHEN 4 THEN 'April'
            WHEN 5 THEN 'May'
            WHEN 6 THEN 'June'
            WHEN 7 THEN 'July'
            WHEN 8 THEN 'August'
            WHEN 9 THEN 'September'
            WHEN 10 THEN 'October'
            WHEN 11 THEN 'November'
            WHEN 12 THEN 'December'
        END
    AS VARCHAR(20)) AS nombre_mes,
    DATEPART(QUARTER, f.fecha_evento) AS trimestre,
    YEAR(f.fecha_evento) AS anio
FROM (
    SELECT fecha_venta AS fecha_evento
    FROM telecom_operacional.dbo.venta
    UNION
    SELECT fecha_reporte AS fecha_evento
    FROM telecom_operacional.dbo.averia
) f
WHERE f.fecha_evento IS NOT NULL;
GO

/* ========= fact_ventas ========= */
INSERT INTO fact_ventas (
    id_venta, sk_cliente, sk_plan, sk_tienda, sk_tiempo, monto_venta, cantidad_venta
)
SELECT
    v.id_venta,
    dc.sk_cliente,
    dp.sk_plan,
    dt.sk_tienda,
    dti.sk_tiempo,
    v.monto AS monto_venta,
    1 AS cantidad_venta
FROM telecom_operacional.dbo.venta v
JOIN telecom_dw.dbo.dim_cliente dc
    ON dc.id_cliente = v.id_cliente
JOIN telecom_dw.dbo.dim_plan dp
    ON dp.id_plan = v.id_plan
JOIN telecom_dw.dbo.dim_tienda dt
    ON dt.id_tienda = v.id_tienda
JOIN telecom_dw.dbo.dim_tiempo dti
    ON dti.fecha = CAST(v.fecha_venta AS DATE);
GO

/* ========= fact_averias ========= */
INSERT INTO fact_averias (
    id_averia, sk_cliente, sk_averia, sk_tiempo, cantidad_averia
)
SELECT
    a.id_averia,
    dc.sk_cliente,
    da.sk_averia,
    dti.sk_tiempo,
    1 AS cantidad_averia
FROM telecom_operacional.dbo.averia a
JOIN telecom_dw.dbo.dim_cliente dc
    ON dc.id_cliente = a.id_cliente
JOIN telecom_dw.dbo.dim_averia da
    ON da.tipo_problema = a.tipo_problema
   AND da.es_controlable = a.es_controlable
JOIN telecom_dw.dbo.dim_tiempo dti
    ON dti.fecha = CAST(a.fecha_reporte AS DATE);
GO