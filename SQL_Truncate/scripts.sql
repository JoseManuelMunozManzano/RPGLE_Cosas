-- Esta tabla tiene un trigger (ver proyecto Trigger_con_SQL) y grabamos información en la tabla de historial USER_HISTORY
SELECT * FROM JOMUMA1.AJEDRECI;

SELECT * FROM JOMUMA1.USER_HISTORY;

-- Si eliminamos registros de AJEDRECI, cada DELETE se grabará en mi historial, pero NO queremos eso.
-- Queremos que se eliminen los registros sin que se dispare el trigger. En estos casos se usa TRUNCATE.
-- Truncate también nos pemite indicar si queremos que los registros se borren ignorando el trigger o que
-- devuelvan un error si el trigger existe.

-- Por ejemplo, esta operación da error porque la tabla tiene un trigger que se dispara en una operación DELETE
TRUNCATE JOMUMA1.AJEDRECI RESTRICT WHEN DELETE TRIGGERS;

-- Pero si queremos borrarlos ejecutaremos
TRUNCATE JOMUMA1.AJEDRECI IGNORE DELETE TRIGGERS;

-- También vale sencillamente
TRUNCATE JOMUMA1.AJEDRECI;
