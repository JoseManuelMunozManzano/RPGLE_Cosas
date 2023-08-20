**FREE
  // ****************************************************************
  // LECTURA DEL FICHERO AJEDRECI
  // ****************************************************************
  ctl-opt main(main);

  dcl-proc main;

    dcl-pi *n;
    end-pi;

    dcl-ds dsAjedrecista qualified inz;
      nombre char(50);
      apellidos char(50);
      federacion char(20);
      elo zoned(4:0);
    end-ds;

    dcl-ds dsAjedrecistasList qualified;
      num_ajedrecista zoned(10:0) inz;
      ajedrecista likeds(dsAjedrecista) dim(100) inz(*likeds);
    end-ds;
    
    dcl-s ajedrecistasJson varchar(2000000);
    
    dcl-s ind zoned(3:0) inz(1);

    Exec Sql
      Set Option commit = *none;

    Exec Sql Declare C1 Cursor For
      SELECT NOMBRE, APELLIDOS, FEDERACION, ELO
      FROM JOMUMA1.AJEDRECI;

    Exec Sql Open C1;

    Exec Sql Fetch C1 into :dsAjedrecista;
    Dow sqlStt = '00000';
      dsAjedrecistasList.num_ajedrecista += 1;
      dsAjedrecistasList.ajedrecista(ind) = dsAjedrecista;
      ind += 1;

      Exec Sql Fetch C1 into :dsAjedrecista;
    Enddo;

    Exec Sql Close C1;

    data-gen dsAjedrecistasList 
      %data(ajedrecistasJson:'countprefix=num_')
      %gen('YAJL/YAJLDTAGEN');

  end-proc;
