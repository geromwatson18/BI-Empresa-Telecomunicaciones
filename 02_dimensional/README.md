# BI-Empresa-Telecomunicaciones

**Proyecto 1 de Inteligencia de Negocios – Empresa de Telecomunicaciones (Grupo 5)**

## 1. Descripción del Problema de Negocio
Este proyecto implementa una solución completa de Inteligencia de Negocios para una empresa de telecomunicaciones que opera en Costa Rica. La organización enfrenta problemas de pérdida de clientes (churn) y gestión de incidencias técnicas. El objetivo es analizar la relación entre ventas, perfiles de cliente, averías reportadas y cancelación del servicio para apoyar la toma de decisiones estratégicas en retención y rentabilidad.

## 2. Arquitectura de la Solución
Base de Datos Operacional (OLTP) → Proceso ETL (SSIS) → Data Warehouse (Modelo Dimensional) → Dashboard Analítico (Power BI)

## 3. Estructura del Repositorio

- **01_origen/**
  - `BDcaso5.sql` – Creación de la base de datos transaccional.
  - `BDcaso5datos.sql` – Generación de datos sintéticos.
  - `requerimientos_kpis.md` – Preguntas de negocio, KPIs y usuarios.
- **02_dimensional/**
  - `telecom_dw_ddl.sql` – Creación del Data Warehouse.
- **03_etl/**
  - `etl_telecom_dw_sqlserver_final.sql` – Script ETL alternativo (T-SQL).
  - `reglas_etl.md` – Tabla de mapeo de transformaciones.
- **04_bi/**
  - `empresa_de_telecomunicaciones.pbix` – Dashboard en Power BI.
- **docs/**
  - `conclusiones.md` – Conclusiones y recomendaciones.

## 4. Integrantes y Roles
- **Raúl Gómez** – Negocio y Documentación
- **Ismael Soto** – Modelo Transaccional
- **Gerom Watson** – Arquitectura Dimensional y GitHub
- **Alejandro Sánchez** – Ingeniería ETL
- **Daniela Quesada** – Analítica BI y Presentación

## 5. Herramientas Utilizadas
- **Base de Datos:** SQL Server
- **ETL:** SQL Server Integration Services (SSIS) / Scripts T-SQL
- **Visualización:** Power BI Desktop
- **Control de Versiones:** GitHub

## 6. Instrucciones de Ejecución

### Paso 1: Base de Datos Transaccional
1. Ejecutar `01_origen/BDcaso5.sql` en SSMS para crear `telecom_operacional`.
2. Ejecutar `01_origen/BDcaso5datos.sql` para insertar los datos sintéticos.

### Paso 2: Data Warehouse
1. Ejecutar `02_dimensional/telecom_dw_ddl.sql` para crear `telecom_dw`.

### Paso 3: ETL
- **Vía SSIS:** Abrir el paquete `ETL_Telecom.dtsx` en Visual Studio (SSDT) y ejecutar.
- **Vía T-SQL:** Ejecutar `03_etl/etl_telecom_dw_sqlserver_final.sql` en SSMS.

### Paso 4: Dashboard
1. Abrir `04_bi/empresa_de_telecomunicaciones.pbix` con Power BI Desktop.
2. Verificar la conexión a `telecom_dw`.

## 7. Trazabilidad y Contribuciones
El historial de commits refleja la participación de todos los integrantes, con ramas de trabajo separadas para cada fase.