**FREE
//*****************************************************************************
// SCROLLCURS
//     Ejemplo de uso de Scroll Cursor
//     Como reutilizar un cursor y tener en cuenta los grupos de activación
//*****************************************************************************
// Un grupo de activación *NEW no permite reutilizar recursos, de ahí que se indique *CALLER
//
// Aunque también se puede indicar un grupo de activación concreto, por ejemplo:
// actgrp('MYACTGRP')
//
// Para cerrar el grupo de activación y por tanto el cursor, se hará entonces:
// rclactgrp MYACTGRP
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

//*****************************************************************************
// PROCESO PRINCIPAL
//*****************************************************************************
dcl-proc main;

  dcl-s id zoned(5:0) inz;
  dcl-s name varchar(50) inz;

  Exec Sql
    SET OPTION COMMIT = *NONE,
               CLOSQLCSR = *ENDACTGRP;
  
  Exec Sql declare C1 scroll cursor for
    SELECT ID, NOMBRE
    FROM JOMUMA1.AJEDRECISTAS;
  
  Exec Sql open C1;

  Exec Sql fetch first from C1 into :id, :name;

  dow sqlStt = '00000';
    snd-msg %char(id) + ' ' + name;

    Exec Sql fetch C1 into :id, :name;
  enddo;

  // No se cierra el cursor y esto tenemos que tenerlo en cuenta en las opciones
  // de compilación del programa y en el hecho de que cuando volvamos a ejecutar,
  // si no indicamos Scroll Cursor, como ya hemos leído todos los registros,
  // ya será fin de fichero y saldremos sin leer nada.
  // Exec Sql close C1;

end-proc;
