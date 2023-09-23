**FREE
//*****************************************************************************
// JM_EX_05
// Examples with SQL
//
// MULTI ROW INSERT
//*****************************************************************************
ctl-opt Main(main) dftactgrp(*no) actgrp(*new);

dcl-c MAX_ROWS const(3);

dcl-ds dsTrabajadores dim(MAX_ROWS) qualified inz;
  nombre char(50);
  apellidos char(50);
  activo ind;
  casado ind;
end-ds;

dcl-proc main;

  exec SQL
    set option commit = *none,
                closqlcsr = *endactgrp,
                alwcpydta = *yes,
                naming = *sys,
                srtSeq = *langidshr;

  dsTrabajadores(1).NOMBRE = 'JUAN';
  dsTrabajadores(1).APELLIDOS = 'MIRAS';
  dsTrabajadores(1).ACTIVO = *off;
  dsTrabajadores(1).CASADO = *on;

  dsTrabajadores(2).NOMBRE = 'PEDRO';
  dsTrabajadores(2).APELLIDOS = 'SOLANO';
  dsTrabajadores(2).ACTIVO = *on;
  dsTrabajadores(2).CASADO = *on;

  dsTrabajadores(3).NOMBRE = 'LUIS';
  dsTrabajadores(3).APELLIDOS = 'SORIANO';
  dsTrabajadores(3).ACTIVO = *off;
  dsTrabajadores(3).CASADO = *off;

  exec SQL
    INSERT INTO TRABAJS (NOMBRE, APELLIDOS, ACTIVO, CASADO)
    :MAX_ROWS ROWS
    VALUES(:dsTrabajadores);
  
end-proc;
