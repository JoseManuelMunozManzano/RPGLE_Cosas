# USING A SCROLL CURSOR

Del video YouTube de Christian Larsen: https://www.youtube.com/watch?v=fPRtGwktis0

Vamos a ver como reutilizar un cursor teniendo en cuenta su grupo de activación.

## Testing

Ejecutar el programa: `CALL SCROLLCURS` y luego `DSPJOBLOG` para ver el resultado.

Constrastar si tenemos ficheros abiertos pulsando `Shift+Esc+3` y la opción `14` seguido de `F11`.

Debería estar abierto nuestro fichero `AJEDRECI`.

Si volvemos a ejecutar y vemos los mensajes del sistema indicará `Cursor C1 already open or allocated`.

Y cuando hagamos el `fetch first from C1`, como hemos hecho un scroll cursor, volverá a leer desde el principio.
