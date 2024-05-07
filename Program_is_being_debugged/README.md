# COMO SABER SI MI PROGRAMA ESTA SIENDO DEBUGGEADO

Del video YouTube de Christian Larsen: https://www.youtube.com/watch?v=Mk9hAdh4Yrg

Hay un comando que devuelve si un programa que se está ejecutando está siendo debuggeado.

Esto sirve para que, en función de si estamos o no en un debug, querramos ejecutar una parte del código o no, o que alguna variable tenga un valor en concreto para probar algo...

Documentación:

- https://www.rpgpgm.com/2019/03/api-to-check-if-debug-is-active.html
- https://www.ibm.com/docs/es/i/7.5?topic=interfaces-alphabetic-list-apis

## Testing

Ejecutar primero el programa directamente: `CALL ISINDEBUG`. Veremos que la variable word vale `Hello`. Confirmar con el comando `dspjoblog`.

Hacer un debug al programa `ISINDEBUG.RPGLE` y ejecutarlo: `CALL ISINDEBUG`. En este caso veremos que la variable word cambia a `racecar`. Confirmar con el comando `dspjoblog`.
