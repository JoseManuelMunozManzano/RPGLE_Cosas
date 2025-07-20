# Funciones OLAP (Online Analytical Processing)

Del video de Christian Larsen: https://www.youtube.com/watch?v=HikVUneV8S4

Vamos a ver funciones OLAP en SQL para IBMi usando DB2 for i.

Estas funciones nos permiten hacer cálculos avanzados directamente en SQL, sin tener que recurrir a bucles o tablas temporales. Permiten computar valores entre filas relacionadas de un resultado de una query mientras mantienen cada fila de forma individual. No agrupan ni reducen filas como hace GROUP BY.

Estas funciones son muy útiles para análisis de datos, como calcular promedios móviles, totales acumulados, rankings, identificar primer y último valor, etc.

Funcionan muy bien en ACS para DB2 for i, y como SQL embebido en programas RPGLE.

## Testing

Ejecutar `olap.sql`.