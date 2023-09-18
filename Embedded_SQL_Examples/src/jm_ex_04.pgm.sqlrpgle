**FREE
//*****************************************************************************
// JM_EX_04
// Examples with SQL
//
// PAGING MULTI ROW FETCH
//*****************************************************************************
ctl-opt Main(main) dftactgrp(*no) actgrp(*new);

dcl-c MAX_ROWS const(4);
// the requested page size
dcl-s pageSize int(10) inz(MAX_ROWS);

dcl-proc main;

  exec SQL
    set option commit = *none,
                closqlcsr = *endactgrp,
                alwcpydta = *yes,
                naming = *sys,
                srtSeq = *langidshr;

  snd-msg ('Number of rows per page: ' + %char(pageSize));
  if pageSize > (MAX_ROWS - 1);
    pageSize = MAX_ROWS - 1;
  endif;

  Declare_And_Open();
  Get_Rows(pageSize);
  Close_Cursor();

end-proc;

// ----------------------------------------------------------------------------
// Declare and Open
// ----------------------------------------------------------------------------
dcl-proc Declare_And_Open;

  exec SQL declare C1 scroll cursor for
    SELECT NOMBRE, APELLIDOS
    FROM TRABAJS
    FOR READ ONLY;

  exec SQL Open C1;

end-proc;

// ----------------------------------------------------------------------------
// Get Rows
// ----------------------------------------------------------------------------
dcl-proc Get_Rows;

  dcl-pi *n;
    pageSize int(10) const;
  end-pi;

  dcl-ds dsData qualified dim(MAX_ROWS) inz;
    firstName char(50);
    lastName char(50);
  end-ds;

  dcl-s i int(10);
  // F --> Forward, B --> Backward, E --> End
  dcl-s direction char(1) inz('F');
  // rows to retrieve on the fetch
  dcl-s getPageSize int(10) inz; 
  // relative offset for next read
  dcl-s relativeRow int(10) inz(1);
  // number of rows fetched
  dcl-s backRows int(10) inz;
  // status for EOF
  dcl-s lastRow int(10) inz;

  dou direction = 'E';

    // reading one more row than page size to detect EOF
    getPageSize = pageSize + 1;

    if direction = 'B';
      relativeRow = 1 - pageSize + backRows;
    endif;

    exec SQL fetch relative :relativeRow from C1 for :getPageSize rows into :dsData;
    backRows = SQLERRD(3);

    exec SQL get diagnostics :lastRow = DB2_LAST_ROW;
    relativeRow = 0;

    // 100 if it's the last row
    if lastRow = 100;
      snd-msg ('Reached EOF');
      direction = 'E';
      relativeRow = 1 - backRows;
    endif;

    if backRows = 0;
      exec SQL fetch first from C1 for :getPageSize rows into :dsData;
      backRows = SQLERRD(3);
    endif;

    for i = 1 to backRows;
      snd-msg ('Name ' + %trim(dsData(i).firstName) + ', Last Name ' + 
        %trim(dsData(i).lastName) );
    endfor;
    snd-msg ('Direction (F/B/E) ' + direction);
  enddo;  

end-proc;

// ----------------------------------------------------------------------------
// Close Cursor
// ----------------------------------------------------------------------------
dcl-proc Close_Cursor;

  exec SQL Close C1;

end-proc;
