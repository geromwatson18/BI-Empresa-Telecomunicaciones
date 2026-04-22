# BI-Empresa-Telecomunicaciones

**Proyecto 1 de Inteligencia de Negocios – Empresa de Telecomunicaciones (Grupo 5)**

## 1. Descripción del Problema de Negocio
Este proyecto desarrolla una solución de Inteligencia de Negocios para analizar el comportamiento de clientes de una empresa de telecomunicaciones en Costa Rica, con énfasis en:
- churn.
- averías/incidencias técnicas.
- ventas por plan, canal y región.

El objetivo es apoyar decisiones de retención y rentabilidad mediante una arquitectura BI completa: origen transaccional, ETL, Data Warehouse y visualización analítica.

## 2. Arquitectura de la Solución
**Base de Datos Operacional (SQL Server) → ETL (SSIS / T-SQL de apoyo) → Data Warehouse Dimensional (SQL Server) → Dashboard Analítico (Power BI)**

## 3. Estructura del Repositorio

- **01_origen/**
  - `BDcaso5.sql` – Script integral del origen: crea `telecom_operacional`, crea tablas y genera datos sintéticos.
  - `requerimientos_kpis.md` – Requerimientos de negocio, KPIs y usuarios de información.

- **02_dimensional/**
  - `telecom_dw_ddl.sql` – Script DDL para crear el Data Warehouse `telecom_dw`.
  - `esquema_estrella.png` – Diagrama del modelo dimensional.

- **03_etl/**
  - `ETL_Telecom_CargaDW.dtsx` – Paquete ETL principal en SSIS.
  - `etl_telecom_dw_sqlserver_final.sql` – Script ETL alternativo en T-SQL.
  - `reglas_etl.md` – Reglas de transformación y mapeo origen-destino.

- **04_bi/**
  - `Empresa de telecomunicaciones..pbix` – Dashboard analítico en Power BI.

- **docs/**
  - `TI6900_Proyecto1_Grupo5.pdf` – Informe final del proyecto.
  - `Proyecto1_Grupo5_Presentacion.pptx` – Presentación final.
  - `conclusiones.md` – Hallazgos y conclusiones.

## 4. Integrantes y Roles
- **Raúl Gómez** – Negocio y Documentación  
- **Ismael Soto** – Modelo Transaccional  
- **Gerom Watson** – Arquitectura Dimensional y GitHub  
- **Alejandro Sánchez** – ETL  
- **Daniela Quesada** – Analítica BI y Presentación  

## 5. Herramientas Utilizadas
- **SQL Server** (OLTP + DW)
- **SQL Server Integration Services (SSIS)**
- **T-SQL**
- **Power BI Desktop**
- **GitHub**

## 6. Instrucciones de Ejecución

### Paso 1: Base de Datos Operacional
1. Abrir SQL Server Management Studio (SSMS).
2. Ejecutar `01_origen/BDcaso5.sql`.


### Paso 2: Data Warehouse
1. Ejecutar `02_dimensional/telecom_dw_ddl.sql` para crear `telecom_dw`.

### Paso 3: ETL
- **Opción oficial:** abrir y ejecutar `03_etl/ETL_Telecom_CargaDW.dtsx` en Visual Studio (SSDT).
- **Opción alterna:** ejecutar `03_etl/etl_telecom_dw_sqlserver_final.sql` en SSMS.

### Paso 4: Dashboard
1. Abrir `04_bi/Empresa de telecomunicaciones..pbix` en Power BI Desktop.
2. Verificar conexión al DW (`telecom_dw`).
3. Actualizar y validar los indicadores.

## 7. Alcance Analítico
El modelo permite analizar:
- ingresos por plan, canal y región,
- relación entre averías y churn,
- segmentación de clientes y comportamiento de cancelación,
- impacto de incidencias técnicas en pérdida de ingresos.
