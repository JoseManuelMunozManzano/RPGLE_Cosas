**FREE
  // *********************************************************************
  // ENCRIPTACION
  // SE ENCRIPTA EL PASSWORD DE ACCESO A UN SISTEMA USANDO AES
  // *********************************************************************
  ctl-opt main(main);

  dcl-proc main;

    dcl-s semilla char(10) inz('MI_SEMILLA');

    Exec Sql
      Set Option commit = *none;
    
    Exec Sql
      Set encryption password :semilla;

    Exec Sql
      INSERT INTO JOMUMA1.USUARIOS_SISTEMA VALUES(
          default,
          'JOSE M.',
          'MUNOZ M.',
          'mimail@hotmail.com',
          ENCRYPT_AES('mi_password_de_sistema', :semilla)
      );

  end-proc;
