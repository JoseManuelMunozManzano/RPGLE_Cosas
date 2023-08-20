**FREE
  // *********************************************************************
  // DESENCRIPTACION
  // SE DESENCRIPTA EL PASSWORD DE ACCESO A UN SISTEMA USANDO AES
  // *********************************************************************
  ctl-opt main(main);

  dcl-proc main;

    dcl-s semilla char(10) inz('MI_SEMILLA');
    dcl-s miPassword char(30) inz;

    Exec Sql
      Set Option commit = *none;
    
    Exec Sql
      Set encryption password :semilla;

    // Importante que el campo PASSWORD tenga "for bit data" para poder ser
    // desencriptado
    Exec Sql
      SELECT DECRYPT_BIT(PASSWORD) 
        Into: miPassword
      FROM JOMUMA1/USUARIOS_SISTEMA
      WHERE EMAIL = 'mimail@hotmail.com';
    
    dsply miPassword;

  end-proc;
