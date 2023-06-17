**free
// *****************************************************************************
// * EJEMPLO DE TRATAMIENTO DE BOOLEANOS EN RPGLE CON SQL EMBEBIDO
// *****************************************************************************
ctl-opt main(main);

dcl-ds dsCharTest qualified;
  chkChar0 varchar(10) inz('0');
  chkChar1 varchar(10) inz('1');
  chkNo varchar(10) inz('no');
  chkN varchar(10) inz('N');
  chkOff varchar(10) inz('OFF');
  chkYes varchar(10) inz('Yes');
  chkY varchar(10) inz('Y');
  chkOn varchar(10) inz('on');
  chkFalse varchar(10) inz('False');
  chkF varchar(10) inz('F');
  chkTrue varchar(10) inz('true');
  chkT varchar(10) inz('T');
  chkOther varchar(10) inz('Nein');

  Arr varchar(10) dim(13) pos(1);
end-ds;

dcl-ds dsNumTest qualified;
  chkNum0 int(10) inz(0);
  chkNum1 int(10) inz(1);
  chkNumOther int(10) inz(17);

  Arr int(10) dim(3) pos(1);
end-ds;

dcl-s locIndicator ind;
dcl-s locCheck varchar(10) inz;
dcl-s locCheckNum int(10) inz;

// *****************************************************************************
// * PROCESO PRINCIPAL
// *****************************************************************************
dcl-proc main;

  // Check character values
  for-each locCheck in dsCharTest.Arr;
    exec sql SET :locIndicator = ISTRUE(:locCheck);
    if sqlStt <> '00000';
      dsply ('SQLSTATE: ' + sqlStt + ' With ' + %trim(locCheck));
    else;
      dsply ('Check ' + locCheck + ' for true is ' + locIndicator);
    endif;
  endfor;

  // Check numeric values
  for-each locCheckNum in dsNumTest.Arr;
    exec sql SET :locIndicator = ISFALSE(:locCheckNum);
    if sqlStt <> '00000';
      dsply ('SQLSTATE: ' + sqlStt + ' With ' + %char(locCheckNum));
    else;
      dsply ('Check ' + %char(locCheckNum) + ' for false is ' + locIndicator);
    endif;
  endfor;

end-proc;

