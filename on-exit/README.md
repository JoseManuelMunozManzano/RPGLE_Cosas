# ON-EXIT

Del video de Christian Larsen: https://www.youtube.com/watch?v=zRRNdiCq7HY

En muchos programas usamos `MONITOR` para recoger los errores que se producen durante la ejecución de un programa, evitando que estos terminen de forma anormal.

Podemos usar también el opcode `ON-EXIT` para capturar errores.

Este código no reemplaza a Monitor, porque con Monitor tenemos más control sobre nuestro código, pero es bueno, usando on-exit, tener la posibilidad de cerrar recursos antes de terminar un programa debido a un error inesperado.

`ON-EXIT` es un opcode que nos permite ejecutar una sección de código cada vez que un procedure (no programa, procedure o subprocedure!) termina, independientemente de que termine correcta o incorrectamente.

Es como el finally de una operación try...catch en Java.

Podemos poner un indicador tras el opcode `ON-EXIT` y el programa lo usará como indicador de error. Chequeando si está o no activo, podremos hacer lo que queramos.

## Testing

En el programa `onexit_ex.sqlrpgle`, primero se ha hecho un ejemplo con el uso normal de `MONITOR` y luego con `ON-EXIT` con el que activamos un indicador.

Para probar hay que poner un debug en la sentencia `MONITOR` y otra en la sentencia del `ON-EXIT` y ejecutar el programa: `CALL ONEXIT_EX`. Lo dejamos ahí.

Hay que tener otra sesión 5250 abierta y con el comando `WRKUSRJOB` accedemos a nuestros trabajos y cerramos de forma inmediata el trabajo que esté ejecutando nuestro programa.

Volvemos a la sesión donde se está ejecutando el programa y vemos que está ahí parado (tenemos un cierto tiempo antes de que se cierre la sesión)
