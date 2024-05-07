create or replace procedure JOMUMA1.SUMA_AND_B2 (
  in a decimal(15, 5),
  in b decimal(15, 5),
  out c decimal(15, 5)
)
-- Indicamos el nombre del procedure del programa de servicio a ejecutar (en mayúsculas)
external name 'JOMUMA1/SRVUTIL(SRVUTIL_SUM_A_AND_B_2)'
-- Indicamos el lenguaje
language rpgle
-- Siempre va a devolver el mismo resultado para los mismos valores de parámetros
deterministic
parameter style general;


create or replace function JOMUMA1.SUMA_AND_B (
  a decimal(15, 5),
  b decimal(15, 5)
) returns decimal(15,5)
external name 'JOMUMA1/SRVUTIL(SRVUTIL_SUM_A_AND_B)'
language rpgle
deterministic
parameter style general;


-- PRUEBAS --

-- PROCEDURE
-- Para confirmar que nuestro procedure funciona, definimos una variable que contendrá el resultado.
create or replace variable JOMUMA1.c dec(15, 5);
set JOMUMA1.C = 0;

-- Ejecutamos el procedimiento almacenado.
CALL JOMUMA1.SUMA_AND_B2(1, 5, JOMUMA1.C);

-- Y para ver el valor de nuestra variable.
VALUES JOMUMA1.C;


-- FUNCTION
-- No nos hace falta definir variables. Se hace la siguiente consulta
SELECT JOMUMA1.SUMA_AND_B(1, 6) FROM SYSIBM.SYSDUMMY1;
