# EJEMPLO CON RPGLE Y LIBRERIA YAJL PARA GENERAR UN JSON

Importante:
Se crea una ds que debe contener el número de registros y los datos y luego se pasan a la variable JSON.

```
    dcl-ds dsAjedrecistasList qualified;
      num_ajedrecista zoned(10:0) inz;
      ajedrecista likeds(dsAjedrecista) dim(100) inz(*likeds);
    end-ds;

    dcl-s ajedrecistasJson varchar(2000000);

    data-gen dsAjedrecistasList
      %data(ajedrecistasJson:'countprefix=num_')
      %gen('YAJL/YAJLDTAGEN');
```

Se hace el deploy con el makefile incluido.

También hay incluido en el fuente qsqlsrc/ajedreci.sql unos insert que sólo habrá que hacer la primera vez que se haga el deploy.
