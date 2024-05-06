-- Esta tabla tiene una UNIQUE KEY, es el campo ID
SELECT * FROM JOMUMA1.AJEDRECISTAS;

-- Actualización del registro ID = 1 con nuevo campo ELO = 2800
-- Si ID no fuera una clave UNIQUE, también se podrían indicar otros campos.
--
-- La tabla a la que llamamos TARGET es AJEDRECISTAS.
-- La tabla a la que llamamos SOURCE solo va a tener un registro, el que tiene ID = 1,
-- e indicamos que queremos realizar la operación cuando el ID de TARGET es el mismo que el de SOURCE,
-- es decir, el 1 en este caso.
--
-- Cuando el registro no existe, entonces vamos a insertar un registro con los valores indicados.
-- Cuando el registro existe, entonces actualizamos el campo ELO de la tabla TARGET.
MERGE INTO JOMUMA1.AJEDRECISTAS AS TARGET
USING (VALUES(1)) SOURCE (ID)
ON TARGET.ID = SOURCE.ID
WHEN NOT MATCHED THEN
  INSERT (NOMBRE, APELLIDOS, FEDERACION, ELO) VALUES ('ANATOLY', 'KARPOV', 'RUSIA', 2800)
WHEN MATCHED THEN
  UPDATE SET TARGET.ELO = 2800;

-- Ahora un ejemplo donde no encuentra el ID y va a insertar.
MERGE INTO JOMUMA1.AJEDRECISTAS AS TARGET
USING (VALUES(6)) SOURCE (ID)
ON TARGET.ID = SOURCE.ID
WHEN NOT MATCHED THEN
  INSERT (NOMBRE, APELLIDOS, FEDERACION, ELO) VALUES('MAGNUS', 'CARLSEN', 'NORUEGA', 2850)
WHEN MATCHED THEN
  UPDATE SET TARGET.ELO = 2850;

-- Ahora un ejemplo donde encuentra el Nombre y actualiza su ELO.
MERGE INTO JOMUMA1.AJEDRECISTAS AS TARGET
USING (VALUES('MAGNUS')) SOURCE (NOMBRE)
ON TARGET.NOMBRE = SOURCE.NOMBRE
WHEN NOT MATCHED THEN
  INSERT (NOMBRE, APELLIDOS, FEDERACION, ELO) VALUES('MAGNUS', 'CARLSEN', 'NORUEGA', 2840)
WHEN MATCHED THEN
  UPDATE SET TARGET.ELO = 2840;

-- Se puede sustituir la operación UPDATE por un DELETE
MERGE INTO JOMUMA1.AJEDRECISTAS AS TARGET
USING (VALUES('MAGNUS')) SOURCE (NOMBRE)
ON TARGET.NOMBRE = SOURCE.NOMBRE
WHEN NOT MATCHED THEN
  INSERT (NOMBRE, APELLIDOS, FEDERACION, ELO) VALUES('MAGNUS', 'CARLSEN', 'NORUEGA', 2840)
WHEN MATCHED THEN
  DELETE;

-- Imaginemos ahora que tenemos una tabla principal más compleja con muchos registros (AJEDRECISTAS), 
-- y una tabla temporal con la misma estructura y que tiene algunos registros (AJEDREZTMP)
-- Queremos recorrer los registros de la tabla temporal y chequear si los registros existen en la tabla principal.
--
-- Si existe, actualizamos el registro de la tabla principal con la data de la tabla temporal (Federación y ELO)
-- Si no existe, insertarmos el registro desde la tabla temporal a la tabla principal.

-- Creamos la tabla temporal
CREATE TABLE JOMUMA1.AJEDREZTMP AS
(SELECT * FROM JOMUMA1.AJEDRECI) WITH NO DATA;

-- Añadimos algunos campos, de los cuales, el último existe en la tabla AJEDRECISTAS, aunque con distinto ID.
INSERT INTO JOMUMA1.AJEDREZTMP VALUES(1, 'LEONID', 'STEIN', 'RUSIA', 2680);
INSERT INTO JOMUMA1.AJEDREZTMP VALUES(2, 'MIHAIL', 'TAL', 'RUSIA', 2680);
INSERT INTO JOMUMA1.AJEDREZTMP VALUES(3, 'BOBY', 'FISHER', 'USA', 2745);

-- Hacemos el merge
MERGE INTO JOMUMA1.AJEDRECISTAS AS TARGET
USING JOMUMA1.AJEDREZTMP AS SOURCE ON TARGET.NOMBRE = SOURCE.NOMBRE
                                  AND TARGET.APELLIDOS = SOURCE.APELLIDOS
WHEN MATCHED THEN
  UPDATE SET FEDERACION = SOURCE.FEDERACION,
             ELO = SOURCE.ELO
WHEN NOT MATCHED THEN
  INSERT (NOMBRE, APELLIDOS, FEDERACION, ELO) VALUES(SOURCE.NOMBRE, SOURCE.APELLIDOS, SOURCE.FEDERACION, SOURCE.ELO);
