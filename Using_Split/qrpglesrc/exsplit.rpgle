**FREE
// *****************************************************************************
//     EXSPLIT
//     Ejemplo de uso de la función %SPLIT
//     Divide una cadena de caracteres usando uno o más separadores
// *****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

// *****************************************************************************
// PROCESO PRINCIPAL
// *****************************************************************************
dcl-proc main;

  dcl-s string varchar(1000);
  dcl-s pieces varchar(50) dim(*auto:50);
  dcl-s piece varchar(50);

  string = '  This is an example   of how to    use split';

  // Dividiendo la cadena usando el separador espacio.
  // Por defecto, no tiene en cuenta posibles cadenas vacías.
  pieces = %split(string:' ');

  // El resultado es This
  snd-msg pieces(1);

  // Indicando el parámetro *ALLSEP se tienen en cuenta cadenas vacías.
  pieces = %split(string:' ':*allSep);

  // El resultado es un espacio en blanco
  snd-msg pieces(1);

  // En vez de guardar el resultado de %split en un array, podemos usarlo
  // como fuente de un bucle for-each
  for-each piece in %split(string:' ':*allSep);
    snd-msg piece;
  endfor;

end-proc;
