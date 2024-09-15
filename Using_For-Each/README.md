# USO DE FOR-EACH

Estos fuentes están inspirados en el siguiente video de Christian Larsen: `https://www.youtube.com/watch?v=Sutk9WRH8rQ`

Usamos `FOR-EACH` para recorrer un array, un subarray, una lista, una división (split), una enumeración e incluso una estructura de datos.

Este bucle usa una variable como operando, que no puede ser un array, y donde se copia cada uno de los valores del array, subarray...

Dentro del bucle se puede usar esa variable para realizar cualquier tipo de operación.

La diferencia entre los bucles `FOR` y `FOR-EACH` es que en el primero usamos el valor del array en las operaciones, por lo que este podría mutar, mientras que en el segundo, se usa una copia de cada posición del array para hacer las operaciones, por lo que los valores del array no pueden mutar.

## Testing

- Ejecutar el programa RPGLE. Se puede hacer debug
  - CALL EXFOREACH
- Usar `DSPJOBLOG` y `F10` para ver resultados
