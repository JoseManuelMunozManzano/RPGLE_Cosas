**free
//*****************************************************************************
// SELECTWHEN
//
// Muestra las nuevas operaciones WHEN-IS y WHEN-IN asociadas a SELECT
// A partir de la versión 7.5
//*****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

dcl-proc main;

  dcl-s i zoned(5:0) inz(2);
  dcl-s n zoned(5:0) inz(5);

  // Select por el resultado de esta operación
  select i + 1;
    // También se puede indicar un range, array o subarray
    when-in %list(1:5:7:8);
      snd-msg 'The operand is in the list';
    // Un valor en concreto
    when-is 5;
      snd-msg 'The operand is the same as n';
    when-is 3;
      snd-msg 'The operand is 3';
    other;
      snd-msg 'The operand has other value';
  endsl;

end-proc;
