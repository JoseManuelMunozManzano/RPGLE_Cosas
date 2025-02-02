# Usar Valores NULL en RPG

Del video YouTube de Christian Larsen: https://www.youtube.com/watch?v=Jd0mIowMzKY

**Programa RPG**

Vamos a ver como usar valores NULL en un programa RPG.

Para activar el uso de NULL (null byte map) en un programa RPG:

- A nivel de parámetros de clt-opt (o Spec H) hay que indicar: `ctl-opt alwnull(*usrctl)`
  - Hay más valores posibles además de `*usrctl`, pero este es el que voy a usar en el ejemplo
- En la declaración de la variable hay que indicar: `dcl-s myVariable varchar(100) nullind`
  - No se puede indicar `nullind` en la definición de un template

Para asignar null a una variable que lo permita se usa `%nullind(myVariable) = *on;`. Notar que la variable puede tener un valor correcto, pero si después de asignar un valor "normal" escribimos esta sentencia, si luego preguntamos si la variable es null nos va a indicar que si.

Para desasignar null a una variable que lo permita se usa `%nullind(myVariable) = *off;`.

Para saber si una variable es null o no se usa `if %nullind(myVariable);`, que devuelve *on o *off.

Para pasar a un procedure una variable que puede ser null:

```
  dcl-pi *n;
    name like(name_t) const options(*nullind);
  end-pi;
```

Notar que hay que indicar `options(*nullind)`.

También se ve en el programa como trabajar con un fichero PF con algún campo que permite null, como escribirlo y como leerlo.

**DDS**

Vamos a ver como trabajar con valores null con ficheros PF.

Por defecto, los campos de un fichero DDS no puede valer null.

Para que un campo de un fichero PF pueda ser null hay que indicarlo usando la opción `ALWNULL`:

`                  FIELD1        30A         ALWNULL`

**Tabla SQL**

En una tabla SQL un campo puede ser null por defecto. De hecho hay que indicar `NOT NULL` durante la creación del mismo para evitar que lo pueda ser.

## Testing

Ejecutar las consultas del fichero `script.sql` para eliminar data.

Ejecutar el siguiente programa: `CALL NULLEX`.
