# BI-Empresa-Telecomunicaciones

**Proyecto 1 de Inteligencia de Negocios – Empresa de Telecomunicaciones (Grupo 5)**

## 1. Descripción del Problema de Negocio
Este proyecto desarrolla una solución de Inteligencia de Negocios para analizar el comportamiento de clientes de una empresa de telecomunicaciones en Costa Rica, con énfasis en:
- churn.
- averías/incidencias técnicas.
- ventas por plan, canal y región.

El objetivo es apoyar decisiones de retención y rentabilidad mediante una arquitectura BI completa: origen transaccional, proceso ETL, Data Warehouse y visualización analítica.

## 2. Arquitectura de la Solución
**Base de datos operacional (SQL Server) → ETL (SSIS / T-SQL de apoyo) → Data Warehouse dimensional (SQL Server) → Dashboard (Power BI)**

## 3. Estructura actual del Repositorio

- **01_origen/**
  - `BDcaso5.sql`  
    Script integral de la base operacional: crea `telecom_operacional`, crea tablas y genera datos sintéticos (clientes, contratos, averías, ventas).
  - `requerimientos_kpis.md`  
    Definición de requerimientos de negocio, KPIs y usuarios de información.

- **02_dimensional/**
  - `telecom_dw_ddl.sql`  
    Script DDL de creación del Data Warehouse `telecom_dw`.
  - `esquema_estrella.png`  
    Diagrama del modelo dimensional.

- **03_etl/**
  - `ETL_Telecom_CargaDW.dtsx`  
    Paquete ETL principal implementado en SSIS.
  - `etl_telecom_dw_sqlserver_final.sql`  
    Script ETL alternativo de apoyo en T-SQL.
  - `reglas_etl.md`  
    Reglas de transformación y mapeo origen-destino.

- **04_bi/**
  - `Empresa de telecomunicaciones..pbix`  
    Dashboard analítico en Power BI.

- **docs/**
  - `conclusiones.md`  
    Hallazgos y conclusiones del análisis.

- **`README.md`**
  - Documento guía del proyecto y ejecución.

## 4. Integrantes y Roles
- **Raúl Gómez** – Negocio y documentación  
- **Ismael Soto** – Modelo transaccional (origen)  
- **Gerom Watson** – Arquitectura dimensional y repositorio GitHub  
- **Alejandro Sánchez** – ETL  
- **Daniela Quesada** – Analítica BI y presentación  

## 5. Herramientas Utilizadas
- **SQL Server** (OLTP + DW)
- **SQL Server Integration Services (SSIS)** para ETL
- **T-SQL** (scripts de soporte y carga)
- **Power BI Desktop** (dashboard)
- **GitHub** (versionamiento y colaboración)

## 6. Instrucciones de Ejecución

### Paso 1: Crear y poblar la base operacional
1. Abrir SQL Server Management Studio (SSMS).
2. Ejecutar `01_origen/BDcaso5.sql`.

> Nota: este script elimina y recrea `telecom_operacional`, luego crea tablas y carga datos sintéticos.

### Paso 2: Crear el Data Warehouse
1. Ejecutar `02_dimensional/telecom_dw_ddl.sql` para crear `telecom_dw`.

### Paso 3: Ejecutar ETL
**Opción oficial (recomendada):**
- Abrir `03_etl/ETL_Telecom_CargaDW.dtsx` en Visual Studio (SSDT) y ejecutar.

**Opción de apoyo (script):**
- Ejecutar `03_etl/etl_telecom_dw_sqlserver_final.sql` en SSMS.

### Paso 4: Visualización
1. Abrir `04_bi/Empresa de telecomunicaciones..pbix` en Power BI Desktop.
2. Verificar conexión al DW (`telecom_dw`).
3. Actualizar datos y validar indicadores.

## 7. Alcance Analítico
El modelo soporta análisis de:
- ingresos por plan, canal y región,
- relación entre averías y churn,
- segmentación de clientes y comportamiento de cancelación,
- impacto de incidencias controlables en pérdida estimada de ingresos.
