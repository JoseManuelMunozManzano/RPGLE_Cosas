-- Do I have the awesome SELF enhancements on this IBM i?
SELECT COUNT(*) AS ENHANCEMENT_THERE
FROM QSYS2.SERVICES_INFO
WHERE SERVICE_SCHEMA_NAME = 'SYSTOOLS'
  AND SERVICE_NAME = 'SQLCODE_INFO';

STOP;

-- On IBM i 7.5 only
SELECT BOOLEAN(COUNT(*)) AS ENHANCEMENT_THERE
FROM QSYS2.SERVICES_INFO
WHERE SERVICE_SCHEMA_NAME = 'SYSTOOLS'
  AND SERVICE_NAME = 'SQLCODE_INFO';

STOP;

-- Is SELF enabled?
-- En SYSIBMADM hay variables globales, una de las cuales se llama SELFCODES. Aquí se indican los errores o warnings de los SQL que queremos vigilar
VALUES SYSIBMADM.SELFCODES;

STOP;

-- set SELF for this job
-- Cada job tiene su instancia de esta variable global, es decir, no se cambia el valor de SYSIBMADM, solo la de mi conexión
SET SYSIBMADM.SELFCODES = '-514, -204, -206';

STOP;

-- Take a look at chess players (FAILS)
SELECT NOMBRE_X
FROM JOMUMA1.AJEDRECISTAS
WHERE ELO > 2700;

STOP;

-- SELF HELP!
-- Hay que tener permiso *ALLOBJ
SELECT *
FROM QSYS2.SQL_ERROR_LOG
WHERE USER_NAME = user;

STOP;

-- Add in explanations for the SQLCODE values
SELECT LOGGED_SQLCODE, MESSAGE_ID, MESSAGE_TEXT, MESSAGE_SECOND_LEVEL_TEXT, LOGGED_SQLSTATE,
       NUMBER_OCCURRENCES, STATEMENT_TEXT, STATEMENT_OPERATION, STATEMENT_OPERATION_DETAIL,
       REASON_CODE, PROGRAM_LIBRARY, PROGRAM_NAME, PROGRAM_TYPE, MODULE_NAME, LOGGED_TIME, JOB_NAME,
       THREAD_ID, ADOPTED_USER_NAME, USER_NAME, SYSTEM_USER_NAME, CLIENT_ACCTNG, CLIENT_APPLNAME,
       CLIENT_PROGRAMID, CLIENT_USERID, CLIENT_WRKSTNNAME, RDB_NAME, INITIAL_LOGGED_TIME,
       INITIAL_JOB_NAME, INITIAL_THREAD_ID, INITIAL_ADOPTED_USER_NAME, INITIAL_STACK
FROM QSYS2.SQL_ERROR_LOG, LATERAL (
    SELECT *
    FROM TABLE (SYSTOOLS_SQLCODE_INFO(P_SQLCODE => LOGGED_SQLCODE))
  );
WHERE USER_NAME = user;

STOP;

-- Change the system default setting to capture SELF detail for all SQL failures
-- (SQLCODE < 0)
CREATE OR REPLACE VARIABLE SYSIBMADM.SELFCODES VARCHAR(256) DEFAULT '*ERROR';

STOP;

-- Change the system default setting to capture SELF detail for all SQL warnings
-- (SQLCODE > 0)
CREATE OR REPLACE VARIABLE SYSIBMADM.SELFCODES VARCHAR(256) DEFAULT '*WARN';

STOP;

-- Turn OFF SELF
CREATE OR REPLACE VARIABLE SYSIBMADM.SELFCODES VARCHAR(256) DEFAULT '*NONE';

STOP;

-- Delete my SELF history
-- Una vez solucionado el problema
VALUES user;

DELETE FROM QSYS2.SQL_ERRORT WHERE USER_NAME = user;

STOP;