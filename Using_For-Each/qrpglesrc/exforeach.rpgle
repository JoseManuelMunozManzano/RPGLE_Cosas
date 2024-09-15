**FREE
// *****************************************************************************
//     EXFOREACH
//     Ejemplo de uso del bucle FOR-EACH para recorrer arrays, subarrays...
// *****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

// *****************************************************************************
// PROCESO PRINCIPAL
// *****************************************************************************
dcl-proc main;

  // Variables
  dcl-s number_t zoned(5:0) template;
  dcl-s numbers like(number_t) dim(*auto:100);
  dcl-s number like(number_t) inz;

  // Estructuras de datos
  dcl-ds dsNode_t qualified template;
    field1 zoned(2:0) inz;
    field2 char(30);
  end-ds;
  dcl-ds dsArray likeds(dsNode_t) dim(*auto:100);
  dcl-ds dsNode likeds(dsNode_t);

  // Importante inicializar el array para no tener valores basura.
  %elem(numbers) = 0;

  numbers(*next) = 1;
  numbers(*next) = 2;
  numbers(*next) = 3;

  // Gracias a haber declarado el array de forma dinámica, con *auto,
  // for-each solo recorre numbers 3 veces, una por cada valor.
  // Si se hubiera declarado el array sin *auto (un array normal), for-each
  // recorrería numbers 100 veces.
  for-each number in numbers;
    snd-msg %char(number);
  endfor;

  // * Podemos recorrer estructuras de datos usando for-each.
  %elem(dsArray) = 0;

  dsArray(1).field1 = 1;
  dsArray(1).field2 = 'Hola';

  dsArray(2).field1 = 2;
  dsArray(2).field2 = 'Adiós';

  for-each dsNode in dsArray;
    snd-msg %char(dsNode.field1) + ' ' + dsNode.field2;
  endfor;

end-proc;
