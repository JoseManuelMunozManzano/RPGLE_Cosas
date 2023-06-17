-- A partir de la versión 7.5 se permite crear tablas con booleanos.
-- Si se ejecuta la consulta desde STRSQL se visualiza como 0-false y 1-true. También puede valer - cuando es NULL
-- Desde Squirrel se ven como true, false y <null>
-- Sus valores hexadecimales son x'F0' para false y x'F1' para true

CREATE OR REPLACE TABLE JOMUMA1.TRABAJADORES FOR SYSTEM NAME TRABAJS (
  "ID" DECIMAL(5, 0) GENERATED ALWAYS AS IDENTITY,
  NOMBRE CHAR(50) CCSID 1145 NOT NULL DEFAULT '',
  APELLIDOS CHAR(50) CCSID 1145 NOT NULL DEFAULT '',
  FECHA_ENTRADA TIMESTAMP default current timestamp,
  ACTIVO BOOLEAN DEFAULT TRUE,
  CASADO BOOLEAN,
  CONSTRAINT JOMUMA1.TRABAJADORESK1 PRIMARY KEY("ID")
) RCDFMT RTRABAJS;

LABEL ON TABLE JOMUMA1.TRABAJADORES IS 'TRABAJADORES';

LABEL ON COLUMN JOMUMA1.TRABAJADORES (
  ID IS 'ID',
  NOMBRE IS 'NOMBRE DE USUARIO',
  APELLIDOS IS 'APELLIDOS DE USUARIO',
  FECHA_ENTRADA IS 'FECHA DE ENTRADA',
  ACTIVO IS 'ESTA ACTIVO',
  CASADO IS 'ESTA CASADO'
);

LABEL ON COLUMN JOMUMA1.TRABAJADORES (
  ID TEXT IS 'ID',
  NOMBRE TEXT IS 'NOMBRE DE USUARIO',
  APELLIDOS TEXT IS 'APELLIDOS DE USUARIO',
  FECHA_ENTRADA TEXT IS 'FECHA DE ENTRADA',
  ACTIVO TEXT IS 'ESTA ACTIVO',
  CASADO TEXT IS 'ESTA CASADO'
);


-- EJEMPLOS DE INSERCIONES 
-- Notar que el campo ACTIVO puede tener el valor TRUE / FALSE, 
--                                              'TRUE' / 'FALSE' 
--                                                  ON / OFF
--                                                'ON' / 'OFF'
--                                                  YES / NO
--                                                'YES' / 'NO'
--                                                    Y / N
--                                                  'Y' / 'N'
--                                                'ON' / 'OFF'
--                                                   1 / 0 
--                                                 '1' / '0'
--                                             default
-- con cualquier tipo de mayúsculas/minúsculas.
--
--INSERT INTO JOMUMA1.TRABAJADORES (NOMBRE, APELLIDOS, ACTIVO) VALUES('PERICO', 'PEREZ', default)
--INSERT INTO JOMUMA1.TRABAJADORES (NOMBRE, APELLIDOS, ACTIVO) VALUES('PERICO', 'PEREZ', FALSE)
--INSERT INTO JOMUMA1.TRABAJADORES (NOMBRE, APELLIDOS, ACTIVO) VALUES('ROBERT', 'DOWNEY JR.', ofF)
--INSERT INTO JOMUMA1.TRABAJADORES (NOMBRE, APELLIDOS, ACTIVO) VALUES('ALBERTO', 'PAN', 0)

-- CASTEOS
-- SELECT BOOLEAN('HOLA') FROM SYSIBM.SYSDUMMY1
-- SELECT BOOLEAN(0) FROM SYSIBM.SYSDUMMY1

-- CREACION XML
-- SELECT XMLGROUP(TRIM(NOMBRE) AS NOMBRE, TRIM(APELLIDOS) AS APELLIDOS, FECHA_ENTRADA, ACTIVO, CASADO)
-- FROM JOMUMA1.TRABAJADORES

-- LECTURA XML
-- SELECT x.*, int(myBoolBoolean) as MyBoolInteger
-- from XMLTABLE('/rowset/row' passing XMLPARSE(Document 
-- 	'<rowset>
-- 		<row><MyID>1</MyID><MyBoolean>false</MyBoolean></row>
-- 		<row><MyID>2</MyID><MyBoolean>true</MyBoolean></row>
-- 	</rowset>')
-- 	Columns MyID Integer path 'MyID',
-- 		   MyBoolVarChar varchar(5) path 'MyBoolean',
-- 		   MyBoolBoolean boolean path 'MyBoolean') x

-- CREACION JSON - BOOLEANO
-- Values(JSON_Object('BooleanTrue':  true,
--                    'BooleanFalse': FALSE));

-- CREACION JSON DESDE TABLA
-- SELECT JSON_OBJECT('DATA': JSON_ARRAYAGG(JSON_OBJECT('MYID': ID,
--              'NOMBRE': TRIM(NOMBRE),
--              'APELLIDOS': TRIM(APELLIDOS),
--              'ACTIVO': ACTIVO,
--              'CASADO': CASADO)))
-- FROM JOMUMA1.TRABAJADORES

-- LECTURA JSON
-- Select x.*, Cast(MyBoolInteger as VarChar(1)) as "MYBOOLCHAR0/1"
--   from JSON_Table('{"DATA":[{"MYID":1,"MYBOOLEAN1":false,"MYCHAR1":false,"MYCHAR2":false,"MYCHAR3":false},
--                             {"MYID":3,"MYBOOLEAN1":true,"MYCHAR1":true,"MYCHAR2":true,"MYCHAR3":false}]}',
--                   '$.DATA[*]'
--                   Columns(MYID             Integer                  Path '$.MYID',
--                           MyBoolVarChar    VarChar(5)               Path '$.MYBOOLEAN1',
--                           MyBoolChar1      Char(1)                  Path '$.MYBOOLEAN1',
--                           MyBoolVarGraphic VarGraphic(5) CCSID 1200 Path '$.MYCHAR1',
--                           MyBoolBoolean    Boolean                  Path '$.MYCHAR2',
--                           MyBoolInteger    Integer                  Path '$.MYCHAR1')) x;     

-- NULL
-- IS NOT TRUE AND IS NOT FALSE

-- FUNCIONES
-- BOOLEAN(x)
-- ISFALSE(x)
-- ISNOTFALSE(x)
-- ISTRUE(x)
-- ISNOTTRUE(x)

-- FUNCIONES AGREGACION
-- ANY(x)   true si encuentra un true en el where indicado
-- SOME(x)  igual que any
-- EVERY(x) true si todo en el where es true
--
-- SELECT ANY(ACTIVO), SOME(ACTIVO), EVERY(ACTIVO) FROM JOMUMA1.TRABAJADORES
