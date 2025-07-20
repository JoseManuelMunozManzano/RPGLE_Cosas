-- CREAMOS LA TABLA E INSERTAMOS DATA.
CREATE TABLE SALES(
  SALE_ID INTEGER GENERATED ALWAYS AS IDENTITY,
  CUSTOMER CHAR(10),
  PRODUCT CHAR(10),
  SALEDATE DATE,
  AMOUNT NUMERIC(9, 2)
);

INSERT INTO SALES (CUSTOMER, PRODUCT, SALEDATE, AMOUNT) VALUES
('ALICE', 'P1', '2024-01-01', 300.00),
('ALICE', 'P2', '2024-01-15', 150.00),
('ALICE', 'P3', '2024-02-01', 300.00),
('BOB',   'P1', '2024-01-20', 100.00),
('BOB',   'P2', '2024-02-10', 200.00),
('BOB',   'P3', '2024-02-10', 400.00),
('CARL',  'P1', '2024-01-10', 400.00),
('CARL',  'P2', '2024-02-01', 400.00);

-- RANK()
-- Podemos usar RANK() para asignar un número de orden a cada fila dentro de un grupo, basado en un criterio de ordenación. Si hay empates, se asigna el mismo rango y se salta el siguiente número.
-- Como ejemplo, vamos a obtener el ranking de ventas por cliente.

WITH RANKED_SALES AS (
  SELECT CUSTOMER, PRODUCT, AMOUNT,
    RANK() OVER (PARTITION BY CUSTOMER ORDER BY AMOUNT DESC) AS RANKING
  FROM SALES
)
SELECT *
FROM RANKED_SALES
WHERE RANKING = 1;

-- DENSE_RANK()
-- Para evitar los saltos en los empates, podemos usar DENSE_RANK() que asigna números consecutivos sin saltos.

SELECT CUSTOMER, PRODUCT, AMOUNT,
  DENSE_RANK() OVER (PARTITION BY CUSTOMER ORDER BY AMOUNT DESC) AS DENSE_RANKING
FROM SALES;

-- NTILE()
-- NTILE() divide el conjunto de resultados en un número especificado de grupos y asigna un número de grupo a cada fila.
-- Este código SQL divide las ventas de cada cliente en dos grupos ("buckets") según el monto (AMOUNT) de cada venta.

SELECT CUSTOMER, PRODUCT, AMOUNT,
  NTILE(2) OVER (PARTITION BY CUSTOMER ORDER BY AMOUNT DESC) AS BUCKET
FROM SALES;

-- SUM() OVER
-- Podemos calcular totales acumulados usando SUM() OVER. Esto nos permite sumar valores de filas anteriores en el conjunto de resultados.
-- Por ejemplo, calcular el total acumulado de ventas (AMOUNT) para cada cliente (CUSTOMER) a lo largo del tiempo (SALEDATE)

SELECT CUSTOMER, SALEDATE, AMOUNT,
  SUM(AMOUNT) OVER (PARTITION BY CUSTOMER ORDER BY SALEDATE ROW BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS RUNNING_TOTAL
FROM SALES;

-- FIRST_VALUE()
-- FIRST_VALUE() nos permite obtener el primer valor de una columna dentro de un grupo definido por PARTITION BY y basado en un criterio de ordenación.
-- Por ejemplo, obtener el primer monto de venta (AMOUNT) para cada cliente (CUSTOMER) ordenado por fecha de venta (SALEDATE).

SELECT CUSTOMER, SALEDATE, AMOUNT,
  FIRST_VALUE(AMOUNT) OVER (PARTITION BY CUSTOMER ORDER BY SALEDATE) AS FIRST_SALE
FROM SALES;

-- LAST_VALUE()
-- LAST_VALUE() nos permite obtener el último valor de una columna dentro de un grupo definido por PARTITION BY y basado en un criterio de ordenación.
-- Por ejemplo, obtener el último monto de venta (AMOUNT) para cada cliente (CUSTOMER) ordenado por fecha de venta (SALEDATE).

SELECT CUSTOMER, SALEDATE, AMOUNT,
  LAST_VALUE(AMOUNT) OVER (PARTITION BY CUSTOMER ORDER BY SALEDATE ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS LAST_SALE
FROM SALES;

-- LAG()
-- LAG() nos permite acceder a una fila anterior dentro del mismo conjunto de resultados. Esto es útil para comparar valores entre filas.
-- Por ejemplo, calcular la diferencia entre el monto de venta (AMOUNT) actual y el monto de venta anterior para cada cliente (CUSTOMER).

WITH LAGGED_SALES AS (
  SELECT CUSTOMER, SALEDATE, AMOUNT,
    LAG(AMOUNT, 1) OVER (PARTITION BY CUSTOMER ORDER BY SALEDATE) AS PREVIOUS_AMOUNT
  FROM SALES
)
SELECT CUSTOMER, SALEDATE, AMOUNT, PREVIOUS_AMOUNT,
  AMOUNT - COALESCE(PREVIOUS_AMOUNT, 0) AS DIFFERENCE
FROM LAGGED_SALES;

-- LEAD()
-- LEAD() nos permite acceder a una fila siguiente dentro del mismo conjunto de resultados. Esto es útil para comparar valores entre filas.
-- Útil para ver tendencias alcitas o bajistas en los datos.
-- Por ejemplo, calcular la diferencia entre el monto de venta (AMOUNT) actual y el monto de venta siguiente para cada cliente (CUSTOMER),

SELECT CUSTOMER, SALEDATE, AMOUNT,
  LEAD(AMOUNT, 1) OVER (PARTITION BY CUSTOMER ORDER BY SALEDATE) AS NEXT_AMOUNT,
  LEAD(AMOUNT, 1) OVER (PARTITION BY CUSTOMER ORDER BY SALEDATE) - AMOUNT AS NEXT_DIFFERENCE
FROM SALES;