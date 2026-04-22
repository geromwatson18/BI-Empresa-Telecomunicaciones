# Requerimientos y Preguntas de Negocio

El diseño de este Data Warehouse no busca simplemente almacenar datos, sino resolver un problema de "ceguera" en la empresa de telecomunicaciones. Actualmente la gerencia sabe que los clientes cancelan sus contratos (churn), pero no pueden medir con exactitud cuánto de esa fuga es culpa de un mal servicio técnico.

Para orientar el modelo a resultados financieros, definimos estas cinco preguntas clave:

1. **Rendimiento por zona:** ¿Cuáles planes y segmentos de clientes generan mayores ingresos dependiendo de la región y el periodo del año?
2. **Impacto del soporte técnico:** ¿Existe un patrón directo entre la cantidad de tickets de avería reportados y la decisión del cliente de cancelar el servicio?
3. **Efectividad de canales de venta:** ¿Qué rinde mejor para cada perfil de cliente, la tienda virtual o las sucursales físicas?
4. **Segmentación de riesgo:** ¿Qué combinaciones específicas de plan, zona geográfica y antigüedad de contrato presentan la mayor probabilidad de churn?
5. **Valor financiero de las averías (Métrica principal):** ¿Cuánto dinero exacto pierde la empresa mensualmente por clientes que cancelan tras sufrir fallas recurrentes que la empresa sí tenía la capacidad de controlar?

## Usuarios del Modelo y KPIs Asignados

El dashboard final y la estructura de datos se pensaron para tres departamentos específicos:

**Gerencia de Operaciones**
* **Objetivo:** Auditar la calidad de la red y el servicio técnico.
* **KPIs:** Volumen total de averías y Tasa de controlabilidad (porcentaje de fallas que son culpa de la infraestructura interna vs. factores externos).

**Ventas y Retención**
* **Objetivo:** Monitorear el rendimiento comercial y adelantarse a la fuga de clientes.
* **KPIs:** Ingresos por canal de venta (físico vs. web) y Tasa de churn segmentada por perfil de consumo.

**Dirección Financiera**
* **Objetivo:** Medir la rentabilidad real de la operación.
* **KPIs:** Ingresos totales facturados y la Pérdida monetaria por mal servicio (el cálculo exacto de ingresos que se dejaron de percibir por averías controlables).
