# TRIGGER CON SQL

Del video de Christian Larsen: https://www.youtube.com/watch?v=u5SH5Or_f1A

Se va a crear un trigger usando SQL.

Lo primero que vamos a hacer es crear esta tabla:

```
CREATE OR REPLACE TABLE JOMUMA1.USER_HISTORY (
  TS timestamp,
  USER char(10) NOT NULL WITH DEFAULT,
  OPERATION char(1) NOT NULL WITH DEFAULT,
  OLDNAME char(50) NOT NULL WITH DEFAULT,
  NEWNAME char(50) NOT NULL WITH DEFAULT,
  OLDSURNAME char(50) NOT NULL WITH DEFAULT,
  NEWSURNAME char(50) NOT NULL WITH DEFAULT,
  OLDELO DECIMAL(4) NOT NULL WITH DEFAULT,
  NEWELO DECIMAL(4) NOT NULL WITH DEFAULT
);
```

Y luego creamos el trigger, que se puede ver en el fuente `trigger.sql` y ejecutamos su creación en el ejecutador de scripts.

## Testing

Tenemos que actualizar o eliminar un registro de la tabla `AJEDRECI` y luego comprobar que se ha informado la tabla `USER_HISTORY`.

Por ejemplo:

```
UPDATE JOMUMA1.AJEDRECI SET ELO = 2800 WHERE NOMBRE = 'ANATOLY';
```

Y vemos que se ha generado un registro en la tabla JOMUMA1.USER_HISTORY

```
SELECT * FROM JOMUMA1.USER_HISTORY;
```
