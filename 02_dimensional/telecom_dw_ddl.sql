IF DB_ID('telecom_dw') IS NOT NULL DROP DATABASE telecom_dw;
GO
CREATE DATABASE telecom_dw;
GO
USE telecom_dw;
GO

CREATE TABLE dim_cliente (
    sk_cliente INT IDENTITY(1,1) PRIMARY KEY,
    id_cliente INT,
    codigo_cliente VARCHAR(20),
    tipo_cliente VARCHAR(20),
    edad INT,
    rango_edad VARCHAR(20),
    sexo VARCHAR(10),
    perfil_consumo VARCHAR(10),
    fecha_registro DATE,
    estado_cliente VARCHAR(10),
    antiguedad_meses INT,
    segmento_antiguedad VARCHAR(20)
);

CREATE TABLE dim_plan (
    sk_plan INT IDENTITY(1,1) PRIMARY KEY,
    id_plan INT,
    nombre_plan VARCHAR(50),
    tipo_plan VARCHAR(20),
    precio DECIMAL(10,2)
);

CREATE TABLE dim_tienda (
    sk_tienda INT IDENTITY(1,1) PRIMARY KEY,
    id_tienda INT,
    nombre_tienda VARCHAR(50),
    tipo_tienda VARCHAR(20),
    region VARCHAR(50)
);

CREATE TABLE dim_averia (
    sk_averia INT IDENTITY(1,1) PRIMARY KEY,
    tipo_problema VARCHAR(50),
    es_controlable VARCHAR(10)
);

CREATE TABLE dim_tiempo (
    sk_tiempo INT IDENTITY(1,1) PRIMARY KEY,
    fecha DATE,
    dia INT,
    mes INT,
    nombre_mes VARCHAR(20),
    trimestre INT,
    anio INT
);

CREATE TABLE fact_ventas (
    sk_fact_venta INT IDENTITY(1,1) PRIMARY KEY,
    id_venta INT,
    sk_cliente INT,
    sk_plan INT,
    sk_tienda INT,
    sk_tiempo INT,
    monto_venta DECIMAL(10,2),
    cantidad_venta INT,
    FOREIGN KEY (sk_cliente) REFERENCES dim_cliente(sk_cliente),
    FOREIGN KEY (sk_plan) REFERENCES dim_plan(sk_plan),
    FOREIGN KEY (sk_tienda) REFERENCES dim_tienda(sk_tienda),
    FOREIGN KEY (sk_tiempo) REFERENCES dim_tiempo(sk_tiempo)
);

CREATE TABLE fact_averias (
    sk_fact_averia INT IDENTITY(1,1) PRIMARY KEY,
    id_averia INT,
    sk_cliente INT,
    sk_averia INT,
    sk_tiempo INT,
    cantidad_averia INT,
    FOREIGN KEY (sk_cliente) REFERENCES dim_cliente(sk_cliente),
    FOREIGN KEY (sk_averia) REFERENCES dim_averia(sk_averia),
    FOREIGN KEY (sk_tiempo) REFERENCES dim_tiempo(sk_tiempo)
);
GO