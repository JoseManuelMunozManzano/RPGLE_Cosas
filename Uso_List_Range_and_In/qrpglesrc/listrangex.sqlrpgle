**FREE
// *****************************************************************************
// LISTRANGEX
//     Ejemplo de uso de %List, %Range e In
// *****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

// *****************************************************************************
// PROCESO PRINCIPAL
// *****************************************************************************
dcl-proc main;

  List_Example();

  Using_In_Instead_Of_Lookup_Example();

  Range_Example();

end-proc;

// -----------------------------------------------------------------------------
// Ejemplo con %List e In
// -----------------------------------------------------------------------------
dcl-proc List_Example;

  dcl-s letter char(1) inz('A');
  dcl-s letter2 char(1) inz('X');

  if letter in %list('A':'B':'C');
    snd-msg 'Yes, it is!' %target(*self:2);
  endif;

  if not (letter2 in %list('A':'B':'C'));
    snd-msg 'No, it is not!' %target(*self:2);
  endif;

end-proc;

// -----------------------------------------------------------------------------
// Ejemplo con In usado en vez de Lookup para buscar en un array
// -----------------------------------------------------------------------------
dcl-proc Using_In_Instead_Of_Lookup_Example;

  dcl-s letters char(1) dim(*auto:100);
  dcl-s letter char(1) inz('A');

  letters = %list('A':'B':'C':'D':'E':'F');

  if letter in letters;
    snd-msg 'Found!' %target(*self:2);
  else;
    snd-msg 'Not Found!' %target(*self:2);
  endif;

end-proc;

// -----------------------------------------------------------------------------
// Ejemplo con %Range e In
// -----------------------------------------------------------------------------
dcl-proc Range_Example;

  dcl-s pi zoned(4:2) inz(3.14);
  dcl-s letter char(1) inz('C');

  if pi in %range(1:10);
    snd-msg 'PI is between 1 and 10' %target(*self:2);
  endif;

  if letter in %range('A':'F');
    snd-msg letter + ' is hexadecimal' %target(*self:2);
  else;
    snd-msg letter + ' is not hexadecimal' %target(*self:2);
  endif;

end-proc;
