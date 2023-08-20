# ENCRIPTACION / DESENCRIPTACION USANDO SQL Y RPGLE

Ejemplo de encriptación y desencriptación usando SQL y RPGLE.
Para el desarrollo se ha usado VSCode y se pasa al 400 usando deploy (ver fichero makefile).

COSAS IMPORTANTES:
En la tabla, el campo que va a estar encriptado debe estar definido así:

```
CAMPO_ENCRIPTADO VARCHAR(128) FOR BIT DATA
```

La semilla que se va a usar para encriptar/desencriptar es mejor que no contenga caracteres extraños como @, #...
