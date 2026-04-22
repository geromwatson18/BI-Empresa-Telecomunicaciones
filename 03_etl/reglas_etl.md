# Reglas de Transformación ETL

# Reglas de Transformación ETL

## Diseño del Modelo Dimensional
Antes de detallar el mapeo de datos, es fundamental visualizar la estructura de nuestro Data Warehouse. El siguiente diagrama muestra el diseño de constelación de hechos, donde se aprecia cómo las dimensiones maestras (como cliente, tiempo y plan) alimentan tanto a la tabla de ventas como a la de averías.

<img width="3253" height="2682" alt="image" src="https://github.com/user-attachments/assets/73b0583d-7b89-4e54-86ec-50f1ee00fe0e" />

Este esquema sirve como hoja de ruta para el proceso ETL, asegurando que las llaves subrogadas y las relaciones se mantengan íntegras durante la carga de datos.

## Tabla de Mapeo ETL

| Campo destino | Campo origen | Regla aplicada | Comentarios |
|---------------|--------------|----------------|-------------|
| `dim_cliente.id_cliente` | `cliente.id_cliente` | Carga directa | Identificador natural del cliente |
| `dim_cliente.codigo_cliente` | `cliente.codigo_cliente` | Carga directa | Código operacional |
| `dim_cliente.tipo_cliente` | `cliente.tipo_cliente` | Carga directa | Residencial o Corporativo |
| `dim_cliente.edad` | `cliente.edad` | Carga directa | Edad del cliente |
| `dim_cliente.rango_edad` | `cliente.edad` | Clasificación por rangos: 18-25, 26-35, 36-50, 51+ | Segmentación demográfica |
| `dim_cliente.sexo` | `cliente.sexo` | Carga directa | Perfil demográfico |
| `dim_cliente.perfil_consumo` | `cliente.perfil_consumo` | Carga directa | Bajo, Medio o Alto |
| `dim_cliente.fecha_registro` | `cliente.fecha_registro` | Carga directa | Fecha de incorporación |
| `dim_cliente.estado_cliente` | `cliente.estado` | Renombre del atributo | Ajuste semántico en el DW |
| `dim_cliente.antiguedad_meses` | `contrato.fecha_inicio` / `cliente.fecha_registro` | Se toma la fecha mínima de inicio de contrato por cliente; si no existe, se usa `fecha_registro`. Luego se calcula diferencia en meses con `GETDATE()`. | Atributo derivado |
| `dim_cliente.segmento_antiguedad` | `dim_cliente.antiguedad_meses` | Clasificación: Nuevo (0-6), Medio (7-24), Antiguo (25+) | Segmentación de churn |
| `dim_plan.id_plan` | `plan.id_plan` | Carga directa | Identificador natural |
| `dim_plan.nombre_plan` | `plan.nombre_plan` | Carga directa | Nombre comercial |
| `dim_plan.tipo_plan` | `plan.tipo_plan` | Carga directa | Prepago o Postpago |
| `dim_plan.precio` | `plan.precio` | Carga directa | Precio base |
| `dim_tienda.id_tienda` | `tienda.id_tienda` | Carga directa | Identificador natural |
| `dim_tienda.nombre_tienda` | `tienda.nombre_tienda` | Carga directa | Nombre del canal |
| `dim_tienda.tipo_tienda` | `tienda.tipo_tienda` | Carga directa | Física o Virtual |
| `dim_tienda.region` | `tienda.region` | Carga directa | Región comercial |
| `dim_averia.tipo_problema` | `averia.tipo_problema` | DISTINCT | Catálogo de tipo de incidencia |
| `dim_averia.es_controlable` | `averia.es_controlable` | DISTINCT | Atributo de clasificación de avería |
| `dim_tiempo.fecha` | `venta.fecha_venta` / `averia.fecha_reporte` | UNION de ambas fechas, CAST a DATE y eliminación de duplicados | Base de dimensión tiempo |
| `dim_tiempo.dia` | `fecha_evento` | Derivación con `DAY()` | Atributo temporal |
| `dim_tiempo.mes` | `fecha_evento` | Derivación con `MONTH()` | Atributo temporal |
| `dim_tiempo.nombre_mes` | `fecha_evento` | Derivación con `DATENAME(MONTH, fecha)` | Etiqueta descriptiva |
| `dim_tiempo.trimestre` | `fecha_evento` | Derivación con `DATEPART(QUARTER, fecha)` | Análisis trimestral |
| `dim_tiempo.anio` | `fecha_evento` | Derivación con `YEAR()` | Análisis anual |
| `fact_ventas.id_venta` | `venta.id_venta` | Carga directa | Referencia operacional |
| `fact_ventas.sk_cliente` | `venta.id_cliente` | Lookup contra `dim_cliente` | Llave subrogada |
| `fact_ventas.sk_plan` | `venta.id_plan` | Lookup contra `dim_plan` | Llave subrogada |
| `fact_ventas.sk_tienda` | `venta.id_tienda` | Lookup contra `dim_tienda` | Llave subrogada |
| `fact_ventas.sk_tiempo` | `venta.fecha_venta` | Lookup contra `dim_tiempo` usando `CAST(fecha_venta AS DATE)` | Relación temporal |
| `fact_ventas.monto_venta` | `venta.monto` | Carga directa | Métrica de ingresos |
| `fact_ventas.cantidad_venta` | Constante | Valor fijo 1 por venta | Conteo de transacciones |
| `fact_averias.id_averia` | `averia.id_averia` | Carga directa | Referencia operacional |
| `fact_averias.sk_cliente` | `averia.id_cliente` | Lookup contra `dim_cliente` | Llave subrogada |
| `fact_averias.sk_averia` | `averia.tipo_problema` + `averia.es_controlable` | Lookup contra `dim_averia` por combinación de atributos | Llave subrogada |
| `fact_averias.sk_tiempo` | `averia.fecha_reporte` | Lookup contra `dim_tiempo` usando `CAST(fecha_reporte AS DATE)` | Relación temporal |
| `fact_averias.cantidad_averia` | Constante | Valor fijo 1 por avería | Conteo de incidencias |
