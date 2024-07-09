# USING UTF8 CHARACTER STRING

Del video de Christian Larsen: https://www.youtube.com/watch?v=FGoFamCnvJ8

Si no especificamos un CCSID el sistema toma el que tenga por defecto.

En RPG se puede convertir muy fácilmente entre distintos CCSID.

En el ejemplo, ha guardado texto en griego (CCSID 851) y ruso (CCSID 878) Ambos CCSID son incompatibles, en el sentido en que no puedo almacenar palabras en griego si el campo se creó codificado para ruso. Para evitar el problema vamos a usar UTF8 (CCSID 1208).

UTF8 es Unicode, que soporta todos los caracteres de todos los lenguajes en un único CCSID, por lo que podemos añadir data en diferentes lenguajes.

Desde la versión 7.2 de RPGLE podemos usar la palabra clave CCSID para asignar diferentes CCSID a nuestras variables char.

## Testing

Seguir los pasos de la ejecución del archivo `scripts.sql`.

Luego ejecutar el programa `CALL JOMUMA1/UTF8EX` y ver en el IFS, el archivo `/home/JOMUMA/utf8ex.txt`.
