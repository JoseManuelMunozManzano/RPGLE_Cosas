# Usar columnas Audit en nuestras tablas

Del video YouTube de Christian Larsen: https://www.youtube.com/watch?v=UjDiVhp5PuU

Esas columnas de audit se usan para almacenar información sobre quién modificó o insertó registros, cual fue la última operación realizada, qué trabajo lo realizó... Hasta ahora, para realizar esto, teníamos que acceder al Journal, y a veces esto es imposible porque la operación fue hace bastante tiempo o no podemos acceder al Journal.

Estas columnas de auditoría se pueden ocultar para que no aparezcan en un SELECT normal, y que nos aparezcan solo cuando necesitamos consultarlas, aunque esto no es obligatorio hacerlo, es posible.

Por último, indicar que un PF no puede tener columnas audit porque no pueden definirse en una DDS. Sin embargo, aunque no se recomienda, se puede usar, sin transformar de PF a Table, la sentencia ALTER TABLE para insertar una columna audit.

Se recomienda, eso si, transformar de PF a Table primero, y luego añadir las columnas audit.

## Testing

Ejecutar las sentencias SQL del archivo `scripts.sql`.
