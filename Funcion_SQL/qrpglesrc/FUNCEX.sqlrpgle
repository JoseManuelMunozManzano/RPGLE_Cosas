**free
// ******************************************************************
// funcex
// Ejemplo de llamada a función SQL
// ******************************************************************
// Compile: 14
// ******************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

dcl-proc main;

  dcl-s nombrePelicula char(150) inz('TIBURON');
  dcl-s anioEstreno zoned(4:0) inz;

  Exec Sql
    SET OPTION COMMIT = *ALL, 
               CLOSQLCSR = *ENDACTGRP,
               ALWCPYDTA = *YES;

  Exec Sql
    SET :anioEstreno = OBTENER_ANIO_ESTRENO_PELICULA(:nombrePelicula);

  snd-msg %char(anioEstreno);

end-proc;
