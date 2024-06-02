-- Borramos por si existiera.
DROP TABLE JOMUMA1.NEWTABLE;

-- Creamos la tabla.
CREATE OR REPLACE TABLE JOMUMA1.NEWTABLE (
  NEWTABLE_ID FOR ID INTEGER GENERATED ALWAYS AS IDENTITY
    (START WITH 1, INCREMENT BY 1, NOCYCLE),
  NEWTABLE_NAME FOR NAME VARCHAR(50) DEFAULT ' ',

  -- Usando columnas audit, vamos a almacenar automáticamente la última operación realizada sobre el registro.
  -- Usando implicitly hidden (no es obligatorio indicarlo) podemos ocultar estas columnas en un SELECT normal.
  NEWTABLE_AUDIT_TYPE_CHANGE FOR AUDTCHG CHAR(1) GENERATED ALWAYS AS
    (DATA CHANGE OPERATION) IMPLICITLY HIDDEN,
  -- Vamos a almacenar automáticamente el usuario que realizó la operación.
  NEWTABLE_AUDIT_USER FOR AUDTUSR VARCHAR(18) GENERATED ALWAYS AS
    (USER) IMPLICITLY HIDDEN,
  -- Vamos a almacenar automáticamente el trabajo.
  NEWTABLE_AUDIT_JOBN FOR AUDTJBN VARCHAR(28) GENERATED ALWAYS AS
    (QSYS2.JOB_NAME) IMPLICITLY HIDDEN,
  -- Vamos a almacenar automáticamente el timestamp de la última operación realizada sobre el registro.
  NEWTABLE_AUDIT_TIMESTAMP FOR AUDTTMS TIMESTAMP GENERATED ALWAYS FOR EACH ROW ON 
    UPDATE AS ROW CHANGE TIMESTAMP NOT NULL IMPLICITLY HIDDEN,
  
  CONSTRAINT PK_NEWTABLE PRIMARY KEY (NEWTABLE_ID)
) RCDFMT RNEWTABLE;

-- Confirmamos que está bien creada.
-- Vemos que no nos aparecen nuestras columnas de auditoría porque están implicitamente ocultas.
-- También la ejecutamos cada vez que queramos ver qué datos tiene la tabla.
SELECT * FROM JOMUMA1.NEWTABLE;

-- Para mostrar una columna oculta tenemos que indicarla en el SELECT.
SELECT NEWTABLE_AUDIT_JOBN FROM JOMUMA1.NEWTABLE;

-- Para mostrar todas las columnas ocultas.
SELECT A.* FROM JOMUMA1.NEWTABLE A;

-- Insertamos un registro. FORMA 1.
INSERT INTO JOMUMA1.NEWTABLE VALUES (
  -- ID. Los valores generados automáticamente se indican con default
  default,
  'First'
);

-- Insertamos un registro. FORMA 2.
-- Forma preferida.
INSERT INTO JOMUMA1.NEWTABLE (NEWTABLE_NAME) VALUES('Second');

INSERT INTO JOMUMA1.NEWTABLE (NEWTABLE_NAME) VALUES('Third');

INSERT INTO JOMUMA1.NEWTABLE (NEWTABLE_NAME) VALUES('Fourth');

-- Eliminamos el primer registro.
DELETE JOMUMA1.NEWTABLE WHERE NEWTABLE_ID = 1;

-- Modificamos un registro.
UPDATE JOMUMA1.NEWTABLE SET NEWTABLE_NAME = 'Other fourth' WHERE NEWTABLE_ID = 4;
