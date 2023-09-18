**FREE
//*****************************************************************************
// JM_EX_03
// Examples with SQL
//
// SEQUENTIAL MULTI ROW FETCH
// SQLERRD
//*****************************************************************************
ctl-opt Main(main);

dcl-proc main;

  dcl-c MAX_ROWS const(3);
  dcl-s i int(10);
  dcl-s getRows int(10) inz(MAX_ROWS);

  dcl-ds dsData qualified dim(MAX_ROWS) inz;
    firstName char(50);
    lastName char(50);
  end-ds;

  exec SQL
    set option commit = *none,
                closqlcsr = *endactgrp,
                alwcpydta = *yes,
                naming = *sys,
                srtSeq = *langidshr;

  exec SQL declare C1 Scroll Cursor For
    SELECT NOMBRE, APELLIDOS
    FROM TRABAJS
    FOR READ ONLY;
  
  exec SQL Open C1;

  dou sqlStt <> '00000';
  
    // fetch relative is relative to the current cursor position in the result set
    // 0 is the current position on the cursor
    // 1 is the next row (the same as fetch next)
    // -1 is the previous row (the same as fetch prior)
    exec SQL fetch relative 1 from C1 for :getRows rows into :dsData;
    for i = 1 to SQLERRD(3);
      // dspjoblog to see the result
      snd-msg ('Name ' + %trim(dsData(i).firstName) + ', Last Name ' + 
        %trim(dsData(i).lastName) );
    endfor;

  enddo;

  exec SQL Close C1;

end-proc;
