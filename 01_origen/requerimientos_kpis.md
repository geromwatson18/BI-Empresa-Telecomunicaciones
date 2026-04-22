# Requerimientos de Negocio y KPIs – Grupo 5

## 1. Preguntas de Negocio

Este proyecto se enfoca en una empresa de telecomunicaciones que busca optimizar la toma de decisiones mediante el análisis de datos. Se requiere entender cómo interactúan los clientes con los planes contratados, la efectividad de los puntos de venta y el impacto real que tienen los problemas técnicos en la permanencia de los usuarios.

| Pregunta de negocio | Usuario principal | Indicador clave |
|---------------------|-------------------|-----------------|
| 1. ¿Qué planes y segmentos de clientes generan mayores ingresos por región y periodo? | Dirección Financiera | Ingresos totales por plan y región |
| 2. ¿Cómo se relacionan las averías o tickets de soporte con la cancelación del servicio? | Gerencia de Operaciones | Tasa de churn según cantidad de averías |
| 3. ¿Qué canales de venta son más efectivos según tipo de plan y perfil del cliente? | Ventas y Retención | Ventas por canal y tipo de cliente |
| 4. ¿Qué combinaciones de plan, zona y antigüedad presentan mayor riesgo de churn? | Ventas y Retención | Segmentos con mayor proporción de clientes inactivos |
| 5. ¿Cuánto dinero pierde la empresa por clientes que cancelan tras reportar fallas recurrentes controlables? | Dirección Financiera | Ingreso perdido por churn atribuible a fallas controlables |


## 2. Perfiles de Usuario

La solución está diseñada para tres perfiles de usuario dentro de la organización, cada uno con necesidades de análisis distintas.

| Usuario | Necesidad de información |
|---------|--------------------------|
| **Gerencia de Operaciones** | Monitorear volumen de averías, identificar si las fallas son controlables y medir la eficiencia de la infraestructura. |
| **Departamento de Ventas y Retención** | Identificar qué canales y planes son más efectivos, y detectar clientes con alto riesgo de cancelación. |
| **Dirección Financiera** | Evaluar ingresos por plan y región, y cuantificar el impacto económico de la cancelación del servicio por fallas técnicas. |

## 3. Indicadores Clave (KPIs)

Los indicadores principales que la solución debe ser capaz de calcular son:

- **Ingresos totales.**  
  Suma de `monto_venta` en `fact_ventas`, segmentable por plan, región, tienda y periodo.

- **Cantidad de ventas.**  
  Conteo de registros en `fact_ventas` por canal, tipo de cliente y periodo.

- **Ticket promedio.**  
  Cociente entre ingresos totales y cantidad de ventas.

- **Total de averías.**  
  Conteo de registros en `fact_averias`, filtrable por tipo de problema y controlabilidad.

- **Tasa de churn.**  
  Proporción de clientes con estado `Inactivo` respecto al total, segmentable por perfil, plan y antigüedad.

- **Ingreso perdido por churn atribuible a fallas controlables.**  
  Suma del monto de ventas de clientes que quedaron `Inactivos` y que tienen registradas averías controlables en `fact_averias`.
