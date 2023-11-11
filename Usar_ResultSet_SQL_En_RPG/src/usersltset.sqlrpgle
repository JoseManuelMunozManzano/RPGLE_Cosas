**free
// *****************************************************************************
// USERSLTSET
// Usa el resultset creado en CRTRSLTSET
// Compilar con opción 14
// *****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

dcl-proc main;

  dcl-s setChessPlayers sqlType(RESULT_SET_LOCATOR);
  dcl-s id zoned(5:0);
  dcl-s nombre char(50);
  dcl-s apellidos char(50);
  dcl-s federacion char(20);
  dcl-s elo zoned(4:0);

  Exec Sql
    set option commit = *none;
  
  // Llamamos al programa que crea nuestro resultset (como un procedure)
  Exec Sql
    call CRTRSLTSET;
  
  // Se asocia el Result_set_locator con el procedure (en este caso el programa)
  Exec Sql
    associate result set locators (:setChessPlayers)
    with procedure CRTRSLTSET;

  // Creamos un cursor para movernos por el resultset
  Exec Sql
    allocate C1 cursor
    for result set :setChessPlayers;

  // Bucle para leer el cursor
  dou sqlStt <> '00000';
    Exec Sql fetch C1 into :id, :nombre, :apellidos, :federacion, :elo;
  
    if sqlStt <> '00000';
      leave;
    endIf;

    snd-msg 'Chess Player: ' + %char(id) + ' ' +
      'Nombre: ' + %trim(nombre) + ' ' + %trim(apellidos) + ' ' +
      'Federación: ' + %trim(federacion) + ' ' +
      'Elo' + %char(elo);

  enddo;

  Exec Sql close C1;

end-proc;
