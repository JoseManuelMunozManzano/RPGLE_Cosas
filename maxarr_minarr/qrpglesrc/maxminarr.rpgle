**FREE
//*****************************************************************************
// MAXMINARR
//   Ejemplo de uso de %MAXARR y %MINARR
//   Buscan en que posición del array se encuentra el elemento máximo y mínimo
//*****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

//*****************************************************************************
// PROCESO PRINCIPAL
//*****************************************************************************
dcl-proc main;

  dcl-ds dsPerson dim(*auto:100) qualified inz;
    id zoned(6:0);
    name varchar(50);
  end-ds;
  dcl-s idx zoned(3:0) inz;
  dcl-s bigger zoned(6:0) inz;
  dcl-s biggerStr varchar(50) inz;
  dcl-s biggerPos zoned(3:0) inz;

  dsPerson(1).id = 123;
  dsPerson(1).name = 'Marina';

  dsPerson(2).id = 230;
  dsPerson(2).name = 'José';

  dsPerson(3).id = 190;
  dsPerson(3).name = 'Adriana';

  // Buscando person con el máximo id
  // Forma fea recorriendo todo el array y comparando
  bigger = 0;
  biggerPos = 0;
  for idx = 1 to %elem(dsPerson);
    if dsPerson(idx).id > bigger;
      bigger = dsPerson(idx).id;
      biggerPos = idx;
    endif;
  endfor;

  snd-msg %char(dsPerson(biggerPos).id) + ' ' + dsPerson(biggerPos).name;

  //? %MaxArr devuelve el índice que contiene el valor máximo
  idx = %maxarr(dsPerson(*).id);
  snd-msg %char(dsPerson(idx).id) + ' ' + dsPerson(idx).name;

  // Buscando person con el máximo name
  // Forma fea recorriendo todo el array y comparando
  bigger = 0;
  biggerPos = 0;
  for idx = 1 to %elem(dsPerson);
    if dsPerson(idx).name > biggerStr;
      biggerStr = dsPerson(idx).name;
      biggerPos = idx;
    endif;
  endfor;

  snd-msg %char(dsPerson(biggerPos).id) + ' ' + dsPerson(biggerPos).name;

  //? %MaxArr devuelve el índice que contiene el valor máximo
  idx = %maxarr(dsPerson(*).name);
  snd-msg %char(dsPerson(idx).id) + ' ' + dsPerson(idx).name;


  //? %MinArr devuelve el índice que contiene el valor mínimo

end-proc;
