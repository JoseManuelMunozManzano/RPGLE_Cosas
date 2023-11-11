# USO DE RESULTSET EN RPG

Estos fuentes están inspirados en el siguiente video de Christian Larsen: `https://www.youtube.com/watch?v=dPmJR7pWCXI`

Se va a utilizar la información de la tabla siguiente:

`SELECT * FROM JOMUMA1.AJEDRECISTAS;`

Los programas necesarios son:

## CRTRSLTSET

Programa RPG que cree un resultset (generalmente el resultset es la salida de un procedimiento almacenado)

Para testear este programa, ejecutar desde el SQL Script: `CALL JOMUMA1.CRTRSLTSET();`

## USERSLTSET

Programa RPG que usa el resultset creado en el programa anterior.

Para testear ejecutar en la línea de comandos: `CALL USERSLTSET`
