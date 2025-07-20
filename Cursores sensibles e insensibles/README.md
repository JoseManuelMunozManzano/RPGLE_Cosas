# Cursores Sensibles e Insensibles

Del video de Christian Larsen: https://www.youtube.com/watch?v=opb7AXfnSH4&t=10s

Si usamos cursores en un programa RPGLE, ¿qué ocurre si alguien actualiza la tabla mientras estamos procesando el cursor?

Aquí es donde entran los cursores sensibles e insensibles.

- Insensitive Cursor: Se comportan como una fotografía de la tabla en el momento en que se abre el cursor. Si alguien actualiza la tabla después de abrir el cursor, los cambios no se reflejarán en el cursor.
  - Ventajas: Conseguimos un mejor rendimiento porque el resulset ya está definido y no tenemos que preocuparnos de cambios en la data.
  - Desventajas: Si alguien actualiza la tabla, no veremos los cambios, no trabajamos con la data más actualizada.

- Sensitive Cursor: Se comportan como una ventana a la tabla. Si alguien actualiza la tabla después de abrir el cursor, los cambios se reflejarán en el cursor.
Los cursores sensibles pueden ser de dos tipos: estáticos y dinámicos. Por defecto, los cursores sensibles son estáticos, lo que significa que son sensibles a eliminaciones y actualizaciones en las tablas. Sin embargo, para reflejar las inserciones en la tabla después de que el cursor ha sido abierto, es necesario utilizar cursores sensibles dinámicos con desplazamiento (scroll). Estos son útiles cuando la frecuencia de transacciones en las tablas es alta.
  - Ventajas: Siempre trabajamos con la data más actualizada.
  - Desventajas: Puede haber problemas de rendimiento porque el resulset puede cambiar mientras lo estamos procesando, y puede que tengamos que volver a leer la data. Si alguien borra un registro antes de hacer un fetch, puede que obtengamos un error.

- Asensitive Cursor: Se comportan como un cursor sensible, pero no se actualizan automáticamente. Si alguien actualiza la tabla después de abrir el cursor, los cambios no se reflejarán en el cursor. Esto lo decide la base de datos.
  - Ventajas: Conseguimos un mejor rendimiento.
  - Desventajas: Perdemos el control. A veces veremos los cambios y otras veces no.
  - Es el valor por defecto si no especificamos nada.

## Testing

Ejecutar el ejemplo de tablas y data de `tipcursor.sql`.

Luego ejecutar el programa `qrpglesrc/tipcursin.sqlrpgle`. Usar un debug y antes de hacer un fetch, modificar un dato de la tabla `CUSTOMERS`. Como usamos un cursor insensitive, no veremos el cambio.

Luego ejecutar el programa `qrpglesrc/tipcursse.sqlrpgle`. En este caso vemos que se actualiza el campo `ORDER_AMOUNT` de la tabla `ORDERS` mientras estamos procesando el cursor. Como usamos un cursor sensitive, podremos hacer el cambio.