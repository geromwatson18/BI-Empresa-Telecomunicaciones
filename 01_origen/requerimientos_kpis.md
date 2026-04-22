# Requerimientos y Preguntas de Negocio

## Preguntas de Negocio
Para resolver la problemática de la empresa, se definieron las siguientes preguntas estratégicas:
1. ¿Qué planes y segmentos de clientes generan mayores ingresos por región y periodo?
2. ¿Cómo se relacionan las averías o tickets de soporte con la cancelación del servicio?
3. ¿Qué canales de venta son más efectivos según tipo de plan y perfil del cliente?
4. ¿Qué combinaciones de plan, zona y antigüedad presentan mayor riesgo de churn?
5. ¿Cuánto dinero pierde la empresa por clientes que cancelan tras reportar fallas recurrentes controlables?

## Usuarios Principales y KPIs
El diseño del modelo dimensional está orientado a tres perfiles principales:

**1. Gerencia de Operaciones**
* **KPIs:** Volumen de averías, Tasa de controlabilidad.
* **Uso:** Evaluar si las fallas técnicas provienen de factores internos (controlables) o externos, para mejorar la infraestructura de red.

**2. Ventas y Retención**
* **KPIs:** Ingresos por canal, Tasa de churn por segmento.
* **Uso:** Analizar el rendimiento de la tienda virtual frente a las sucursales físicas y detectar patrones en los clientes que abandonan la empresa.

**3. Dirección Financiera**
* **KPIs:** Ingresos totales, Pérdida económica por averías controlables.
* **Uso:** Cuantificar el impacto real del mal servicio técnico sobre los ingresos de la compañía.