# UPDATING TABLE WHILE USING CURSOR

Del video de Christian Larsen: https://www.youtube.com/watch?v=7fjFet8U1wY

Podemos actualizar data en una tabla mientras estamos usando un cursor.

Para ello, en WHERE se usa `CURRENT OF <nombre_cursor>`.

Limitaciones:

- No puede actualizarse data usando un cursor si el SQL tiene un JOIN.
- No podemos usar una VIEW
- En la consulta, no podemos usar GROUP BY, HAVING ni DISTINCT

## TESTING

Ejecutar el programa directamente desde VSCode: `CALL UPDTBLCUR`
