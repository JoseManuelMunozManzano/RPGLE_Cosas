**free
//***********************************************************
// Programa ejempplo de manejo de errores
// Si esperamos cualquier tipo de error
//***********************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*new);

dcl-proc main;

  dcl-s gAmount packed(9:2) inz(100);
  dcl-s gDivisor packed(5:0) inz;
  dcl-s gResult packed(9:2) inz;
  dcl-s gPrices packed(7:2) dim(3) inz;
  dcl-s gIndex int(10) inz(5);

  gPrices(1) = 10;
  gPrices(2) = 20.75;
  gPrices(3) = 5.25;

  // Situación 1: División por cero.
  monitor;
    gResult = gAmount / gDivisor;
  on-error 00102;
    gResult = 0;
    snd-msg 'Division by zero avoided, result set to zero';
  endmon;

  // Situación 2: array index out of bounds
  monitor;
    gResult = gPrices(gIndex);
  on-error 00121;
    gResult = -1;
    snd-msg 'Invalid array position, result set to -1';
  endmon;

end-proc;
