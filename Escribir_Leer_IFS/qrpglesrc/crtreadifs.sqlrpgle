**FREE
  //********************************************************
  // CREANDO FICHERO IFS CON RPGLE Y SQL
  // TAMBIEN LEE DE IFS
  //********************************************************
  ctl-opt main(main);

  dcl-proc main;

    dcl-s texto varchar(200);
    dcl-s linea zoned(5:0);

    Exec Sql
      Set Option commit = *none,
                 closqlcsr = *endmod;

    texto = 'Ejemplo de texto en IFS';
    Guarda_Texto_IFS(texto);

    linea = 1;
    Lee_Texto_IFS(linea:texto);

    return;
  end-proc;

  //--------------------------------------------------------
  // Añade texto a un IFS
  //--------------------------------------------------------
  dcl-proc Guarda_Texto_IFS;

    dcl-pi *n;
      texto varchar(200);
    end-pi;

    Exec Sql
      CALL QSYS2.IFS_WRITE_UTF8(PATH_NAME => '/home/JOMUMA/writereadifs/test.txt',
                           LINE => :texto,
                           OVERWRITE => 'APPEND',
                           END_OF_LINE => 'CRLF');

    return;

  end-proc;

  //--------------------------------------------------------
  // LEE texto de un IFS
  //--------------------------------------------------------
  dcl-proc Lee_Texto_IFS;

    dcl-pi *n;
      linea zoned(5:0);
      texto varchar(200);
    end-pi;

    Exec Sql
      SELECT LINE into :texto
      FROM TABLE(QSYS2.IFS_READ('/home/JOMUMA/writereadifs/test.txt'))
      WHERE LINE_NUMBER = :linea;

    return;

  end-proc;
