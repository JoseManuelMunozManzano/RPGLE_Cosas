# NODE - LLAMANDO A PROGRAMA RPGLE QUE DEVUELVE UN RESULTSET

Lo que hace esta aplicación de Node es, usando odbc, llamar a un programa RPGLE que devuelve un RESULTSET.

De esta forma, es posible llamar al programa RPG como si fuera una consulta SQL, sin tener que usar procedimientos almacenados, con esta instrucción:

```
call JOMUMA1.RESULTTEST()
```

Y devuelve la data.

Es posible ejecutar esta instrucción en Squirrel o la utilidad Run Sql Scripts.

1. Para instalar

```
npm i
```

2. Llevarlo al 400.

- Carpeta qrpglesrc: Llevar el fuente a la biblioteca deseada y compilar con 14
- Carpeta js: al IFS. Cambiar cadena de conexión si procede y la biblioteca donde esté compilado el programa RESULTTEST

3. Ejecutar el programa node

```
npm start
```
