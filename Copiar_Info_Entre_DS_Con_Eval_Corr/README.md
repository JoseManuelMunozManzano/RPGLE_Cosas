# Usar EVAL CORR para copiar información de una DS a otra

Del video YouTube de Christian Larsen: https://www.youtube.com/watch?v=5yS3HPw14r4

En concreto, queremos copiar información de una DS a otra cuando ambas estructuras no son iguales.

Vamos a usar la instrucción `EVAL-CORR` que sirve para copiar información entre estructuras, y tiene en cuenta el nombre y el tipo de los campos que contienen dichas estructuras.

Con esta instrucción evitamos tener que asignar a cada campo de una estructura, el campo de la otra estructura, evitando errores y disminuyendo la cantidad de código.

## Testing

Tenemos un programa llamado `evalcorre1.rpgle` para probar como se realiza la copia entre estructuras usando EVAL-CORR.

Ejecución: `CALL EVALCORRE1` usando debug para ver como copia la data.

Para un segundo programa que usa una pantalla hemos creado los siguientes fuentes:

- AJEDRECFM.DSPF
- EVALCORRE2.RPGLE

Ejecución: `CALL EVALCORRE2` usando debug para ver como copia la data.
