**FREE
// *****************************************************************************
// UTF8EX
//     Ejemplo de programa que usa CCSID
// *****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

// *****************************************************************************
// PROCESO PRINCIPAL
// *****************************************************************************
dcl-proc main;

  // Sin especificar CCSID, se asignará el CCSID del trabajo en tiempo de ejecución
  dcl-s field1 varchar(100);
  // Especificando CCSID griego
  dcl-s field2 varchar(100) ccsid(851);
  // Especificando CCSID UTF8
  // Se puede indicar el CCSID 1208 o esta forma especial
  dcl-s field3 varchar(100) ccsid(*utf8);
  dcl-s fieldUTF8 varchar(100) ccsid(*utf8);

  // RPG también puede convertir cadenas escritas como constantes en nuestro código al CCSID
  // requerido, siempre que sea compatible.
  field1 = 'Hello';
  // Se realiza conversión automática al CCSID UTF8
  field3 = field1;

  // Obteniendo la data en formato UTF8
  Exec Sql
    SELECT TEXT
      into :field3
    FROM JOMUMA1.UTF8DATA
    WHERE ID = 1;
  
  fieldUTF8 = field3;

  Exec Sql
    SELECT TEXT
      into :field3
    FROM JOMUMA1.UTF8DATA
    WHERE ID = 2;

  fieldUTF8 += field3;

  // El texto griego concatenado al ruso, lo escribimos en el IFS
  Exec Sql
    CALL QSYS2.IFS_WRITE_UTF8(
      path_name => '/home/JOMUMA/utf8ex.txt',
      line => :fieldUTF8,
      overwrite => 'REPLACE'
    );

end-proc;
