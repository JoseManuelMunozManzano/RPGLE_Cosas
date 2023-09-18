**FREE
//*****************************************************************************
// JM_EX_01
// Examples with SQL
//
// set option
// get diagnostics  (DB2_NUMBER_ROWS, ROW_COUNT)
// SQLERRD
// values into
// set
// multi row fetch
//*****************************************************************************
ctl-opt Main(main);

dcl-proc main;

  dcl-ds dsName qualified dim(2) inz;
    name char(50);
    lastName char(50);
  end-ds;

  dcl-s sqlerrd_03 zoned(3:0) inz;

  dcl-s numTotalRows zoned(3:0) inz;
  dcl-s numRowsFetched zoned(3:0) inz;
  dcl-s system char(10) inz;

  // https://www.ibm.com/docs/en/rdfi/9.6.0?topic=statements-set-option
  exec SQL
    set option commit = *none,
               closqlcsr = *endactgrp,
               alwcpydta = *yes,
               naming = *sys,
               srtSeq = *langidshr;

  // How many rows in resultset.
  // Previous SQL statement was OPEN or FETCH
  exec SQL declare C1 cursor for
    SELECT NOMBRE, APELLIDOS
    FROM TRABAJS
    FOR READ ONLY;
  
  exec SQL open C1;

  exec SQL
    get diagnostics :numTotalRows = DB2_NUMBER_ROWS;
  
  exec SQL fetch C1 for 2 rows into :dsName;

  // https://www.ibm.com/docs/es/db2woc?topic=tables-sqlca-sql-communications-area
  // SQLERRD(3) has the number of rows fetched === ROW_COUNT
  sqlerrd_03 = SQLERRD(3);

  exec SQL
    get diagnostics :numRowsFetched = ROW_COUNT;  

  dsply ('Open C1 DB2_NUMBER_ROWS= ' + %char(numTotalRows));
  dsply ('SQLERRD(1)= ' + %char(sqlerrd_03));
  dsply ('ROW_COUNT= ' + %char(numRowsFetched));

  exec SQL close C1;

  // VALUES INTO looks the same as SET
  exec SQL VALUES current_server INTO :system;
  dsply ('VALUES INTO SYSTEM= ' + system);

  exec SQL SET :system = current_server;
  dsply ('SET SYSTEM= ' + system);

end-proc;
