# Create Function y Create Procedure

Del video de Christian Larsen: https://www.youtube.com/watch?v=nLWZgT9BSGc

Vamos a hacer procedimientos almacenados (procedimientos y funciones) con la gracia de que desde estos vamos a llamar a procedures de programas de servicios RPG. Sería como un cascarón para llamar a otro tipo de programas en otros lenguajes.

- Primero vamos a crear un programa de servicio que contiene un conjunto de procedimientos y funciones: `SRVUTIL.RPGLE`, su copy file `SRVUTIL_H.RPGLE` y su binder language `SRVUTIL.BND`

- Hacemos el store procedure y la función. El store procedure llamará a `SRVUTIL_Sum_A_And_B` y la función a `SRVUTIL_Sum_A_And_B_2`. Los fuentes están en `scripts.sql`

- También se ha hecho un programa RPG que usa el procedure y la functión DB2: `callprfuex.sqlrpgle`

## Testing

Nos llevamos el copy file `SRVUTIL_H.RPGLE` y el binder language `SRVUTIL.BND` al 400 de forma manual, creándonos los fuentes y copiando el contenido.

Compilamos el programa de servicio `SRVUTIL.RPGLE` y creamos el programa de servicio (los mandatos están en el fuente)

Ejecutamos en la utilidad `Run SQL Scripts` el fuente `scripts.sql`.

Los dos primeros scripts generan el procedure y la function, pero a partir del tercero sirve para realizar las pruebas.

Para hacer la prueba de un programa RPG que usa el store procedure y la function que a su vez llaman a procedures de un programa de servicio, solo hay que compilar el programa `callprfuex.sqlrpgle` y hacer un debug para ir viendo los resultados que genera. O, al terminar, ejecutar `dspjoblog` para ver el resultado.

Ejecutamos con: `CALL CALLPRFUEX`
