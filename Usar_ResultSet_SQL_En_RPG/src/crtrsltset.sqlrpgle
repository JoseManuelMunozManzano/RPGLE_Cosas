**free
// *****************************************************************************
// CRTRSLTSET
// Devuelve un resulset
// Compilar con opción 14
// *****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

dcl-proc main;

  dcl-ds dsChessPlayers dim(*auto:1000) qualified inz;
    id zoned(5:0);
    nombre char(50);
    apellidos char(50);
    federacion char(20);
    elo zoned(4:0);
  end-ds;
  dcl-s max zoned(4:0) inz;
  dcl-s elements zoned(4:0) inz;

  %elem(dsChessPlayers) = 0;

  Exec Sql
    set option commit = *none;
  
  Exec Sql declare C1 Cursor For
    SELECT ID, NOMBRE, APELLIDOS, FEDERACION, ELO 
    FROM JOMUMA1.AJEDRECISTAS
    ORDER BY ELO DESC;
  
  Exec Sql Open C1;

  max = 1000;
  Exec Sql fetch C1 for :max rows into :dsChessPlayers;

  Exec Sql Close C1;

  elements = %elem(dsChessPlayers);

  // Esta sentencia es la que realmente genera el RESULTSET
  Exec Sql
    SET RESULT SETS ARRAY :dsChessPlayers FOR :elements ROWS;

end-proc;
