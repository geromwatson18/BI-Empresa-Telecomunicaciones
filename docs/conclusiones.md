# Conclusiones y Recomendaciones

## Conclusiones

El proyecto logró cubrir todos los objetivos planteados:

- Se construyó la base transaccional `telecom_operacional` con datos sintéticos coherentes.
- Se diseñó e implementó el modelo dimensional `telecom_dw` bajo un esquema de constelación de hechos.
- Se desarrolló el proceso ETL mediante SQL Server Integration Services (SSIS), garantizando la trazabilidad desde el origen hasta el DW.
- Se elaboró un dashboard en Power BI que responde a las cinco preguntas de negocio definidas.

Los datos cargados en el DW coinciden con los volúmenes esperados: 1.000 clientes, 2.000 ventas y 3.000 averías, validando la correcta ejecución del ETL.

La decisión de utilizar dos tablas de hechos (`fact_ventas` y `fact_averias`) en lugar de una sola fue clave. Mezclar ventas y averías en un único fact habría generado numerosos campos nulos y habría complicado las consultas analíticas. Con las tablas separadas, el modelo es más limpio, escalable y responde eficientemente a las preguntas de negocio, especialmente aquellas que requieren cruzar comportamiento comercial con incidencias técnicas.

El indicador adicional propuesto por el grupo —**ingreso perdido por churn atribuible a fallas controlables**— demostró ser el de mayor valor estratégico. Es el único KPI que convierte datos operativos de averías en una cifra financiera concreta, proporcionando a la gerencia una justificación cuantitativa para priorizar inversiones en infraestructura y soporte técnico.

El ETL implementado funcionó correctamente bajo la estrategia de *full load* (carga completa con limpieza previa). Si bien este enfoque no es óptimo para entornos de producción con grandes volúmenes de datos, resultó adecuado para el alcance académico del proyecto, garantizando consistencia y reproducibilidad en cada ejecución.

## Recomendaciones para Trabajo Futuro

- **Migrar a cargas incrementales:** En un entorno real, el ETL debería evolucionar hacia un modelo de carga incremental (CDC o marca de agua) para manejar eficientemente millones de registros sin reprocesar toda la historia.

- **Incorporar un score de riesgo de churn:** Durante el proceso ETL se podría calcular un puntaje de propensión a la cancelación (basado en antigüedad, número de averías, tipo de plan, etc.) y almacenarlo directamente en `dim_cliente`. Esto simplificaría los cálculos en Power BI y mejoraría el rendimiento del dashboard.

- **Incluir la dimensión `contrato` en el modelo dimensional:** Actualmente la información de contratos solo se utiliza para derivar la antigüedad. Incorporar una dimensión `dim_contrato` o una tabla de hechos de estado del cliente permitiría analizar la duración real de los contratos, renovaciones y patrones de cancelación por tipo de plan y región, enriqueciendo aún más las capacidades analíticas.
