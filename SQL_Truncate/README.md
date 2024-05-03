# USING THE TRUNCATE SQL STATEMENT

Del video de Christian Larsen: https://www.youtube.com/watch?v=6uHwI7Gqh14

Cuando queremos eliminar un registro de una tabla que tiene un trigger y no queremos que se dispare dicho trigger, tenemos que:

- Eliminar el trigger de la tabla
- Eliminar los registros
- Añadir el trigger a la tabla

En este caso, podemos hacer todo a la vez con una sencilla operación: `truncate`.

## Testing

En la utilidad `run scripts` ejecutar los SQL del fichero `scripts.sql`.
