**FREE
//*****************************************************************************
// JM_EX_02
// Examples with SQL
//
// DECLARE GLOBAL TEMPORARY
//*****************************************************************************
ctl-opt Main(main);

dcl-proc main;

  exec SQL
    set option commit = *none,
                closqlcsr = *endactgrp,
                alwcpydta = *yes,
                naming = *sys,
                srtSeq = *langidshr;

  // temporary tables
  // https://www.ibm.com/docs/en/i/7.5?topic=statements-declare-global-temporary-table
  // https://www.idug.org/blogs/brian-laube1/2023/04/23/temporary-tables-and-painful-lesson
  exec SQL declare global temporary table TEMP_TRABAJOS as
    (SELECT * FROM TRABAJS) WITH DATA;
  
  exec SQL
    UPDATE TEMP_TRABAJOS SET CASADO = TRUE WHERE ID = 1;

end-proc;
