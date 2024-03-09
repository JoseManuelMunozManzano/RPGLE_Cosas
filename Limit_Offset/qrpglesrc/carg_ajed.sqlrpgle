**FREE
//*******************************************************************
// CARG_AJED
//
// Carga 10.000 registros en la tabla AJEDRECI
//*******************************************************************
// COMPILACIÓN: 14
// EJECUCIÓN: Desde la pantalla de ejecutar scripts SQL:
//      cl: call carg_ajed;
//*******************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

dcl-proc main;

  dcl-s number zoned(5:0) inz;
  dcl-s playerName char(50) inz;
  dcl-s playerLastName char(50) inz;
  dcl-s playerFederation char(50) inz;
  dcl-s ELO zoned(4:0) inz;

  for number = 6 to 10000;
    playerName = 'PLAYER ' + %char(number);
    playerLastName = 'LASTNAME ' + %char(number);
    playerFederation = 'ESPAÑA';
    ELO = 2690;

    exec sql
      insert into jomuma1.ajedreci values(
        default,
        :playerName,
        :playerLastName,
        :playerFederation,
        :ELO
      );

  endfor;

end-proc;
