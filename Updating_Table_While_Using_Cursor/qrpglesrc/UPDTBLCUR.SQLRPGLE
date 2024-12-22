**FREE
// ****************************************************************************
// UPDTBLCUR
//     Actualizar una tabla usando un cursor
// ****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

// ----------------------------------------------------------------------------
// PROCESO PRINCIPAL
// ----------------------------------------------------------------------------
dcl-proc main;

  dcl-s federacion char(20) inz;

  Exec Sql
    set option commit = *none;

  // Para este ejemplo voy a actualizar el ELO de los ajedrecistas cuya
  // federación no es RUSIA, usando un cursor.
  // NOTA: No hace falta cursor para hacer esto, se hace por motivos didácticos.
  Exec Sql declare c1 cursor for
      SELECT FEDERACION FROM AJEDRECISTAS;
  Exec Sql open c1;

  dou sqlStt <> '00000';
    Exec Sql fetch next from c1 into :federacion;

    if sqlStt <> '00000';
      leave;
    endif;

    if federacion <> 'RUSIA';
      // Usamos CURRENT OF <nombre_cursor> para inndicar qué registro hay
      // que actualizar.
      Exec Sql
        UPDATE AJEDRECISTAS
          SET ELO = ELO + 25
        WHERE CURRENT OF c1;
      snd-msg 'Elo changed';
    else; 
      snd-msg 'Elo not changed. Russian player';
    endif;
  enddo;

  Exec Sql close c1;

end-proc;
