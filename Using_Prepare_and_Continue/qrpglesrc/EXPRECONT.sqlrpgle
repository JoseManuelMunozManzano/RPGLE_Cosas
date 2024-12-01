**FREE
//*****************************************************************************
// EXPRECONT
//     Ejemplo de uso PREPARE y CONTINUE, y values ... into
//*****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

// ****************************************************************************
// PROCESO PRINCIPAL
// ****************************************************************************
dcl-proc main;

  dcl-s statement varchar(100) inz;
  dcl-s records zoned(5:0) inz;

  Insert_Record('TIGRAN':'PRETROSIAN':'RUSIA':2620);
  Insert_Record('MIKHAIL':'BOTVINNIK':'RUSIA':2590);

  statement = 'values (select count(*) from ajedreci) into ?';

  // SQL convierte statement en una sentencia leible por SQL.
  Exec Sql prepare numberOfRecords from :statement;

  // Indicamos el parámetro ? indicado en statement.
  // En este caso es la variable que contendrá el resultado del SQL.
  Exec Sql execute numberOfRecords using :records;

  snd-msg %char(records);

end-proc;

// ----------------------------------------------------------------------------
// Insertar un registro
// ----------------------------------------------------------------------------
dcl-proc Insert_Record;

  dcl-pi *n;
    nombre varchar(50) const;
    apellidos varchar(50) const;
    federacion varchar(20) const;
    elo zoned(4:0) const;
  end-pi;

  // No se puede usar directamente las variables pasadas al subprocedure porque
  // son const y la sentencia SQL Execute cambia el contenido de la variable.
  dcl-s nombre_p like(nombre);
  dcl-s apellidos_p like(apellidos);
  dcl-s federacion_p like(federacion);
  dcl-s elo_p like(elo);
  dcl-s statement varchar(300);

  nombre_p = nombre;
  apellidos_p = apellidos;
  federacion_p = federacion;
  elo_p = elo;

  statement = 'INSERT INTO AJEDRECI VALUES (default, ?, ?, ?, ?)';

  Exec Sql prepare insertRecord from :statement;

  Exec Sql execute insertRecord using :nombre_p, :apellidos_p, :federacion_p, :elo_p;

end-proc; 
