**free
// ****************************************************************************
// FINDTEST
// EJEMPLO PARA ENCONTRAR FICHEROS EN BIBLIOTECAS Y RUTAS.
// ****************************************************************************
ctl-opt main(main);

// ****************************************************************************
// PROCESO PRINCIPAL
// ****************************************************************************
dcl-proc main;

  dcl-pi *n;
  end-pi;

  dcl-s encontrado ind inz;

  Exec Sql
    SELECT '1' 
      into :encontrado
    FROM TABLE 
    (QSYS2.IFS_OBJECT_STATISTICS (
        Start_Path_Name => '/QSYS.LIB/JOMUMA1.LIB/HOBBIES.FILE', 
        Subtree_Directories => 'YES')
    ) x
    FETCH FIRST ROW ONLY;

  Exec Sql
    SELECT '1' 
      into :encontrado
    FROM TABLE 
    (QSYS2.IFS_OBJECT_STATISTICS (
        Start_Path_Name => '/QSYS.LIB/JOMUMA1.LIB/HOBBIES2.FILE', 
        Subtree_Directories => 'YES')
    ) x
    FETCH FIRST ROW ONLY;

end-proc;
