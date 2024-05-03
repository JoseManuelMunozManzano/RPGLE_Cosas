-- Para ver su valor
SELECT RRN(A) AS RRN, A.* FROM JOMUMA1.AJEDRECI A;

-- Para actualizar una fila basado en el valor de RRN
UPDATE JOMUMA1.AJEDRECI A SET A.ELO = 2870 WHERE RRN(A) = 6;

-- Para eliminar un registro basado en el valor de RRN
DELETE JOMUMA1.AJEDRECI A WHERE RRN(A) = 6;
