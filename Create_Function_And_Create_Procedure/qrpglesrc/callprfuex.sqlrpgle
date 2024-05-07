**FREE
//*****************************************************************************
// CALLPRFUEX
//     Ejemplo de programa que llama a un store procedure y una function DB2
//*****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

//*****************************************************************************
// PROCESO PRINCIPAL
//*****************************************************************************
dcl-proc main;

  dcl-s sum zoned(6:0) inz;

  // Llamando al store procedure
  Exec Sql
    CALL JOMUMA1.SUMA_AND_B2(4, 2, :sum);
  
  snd-msg %char(sum) %target(*self:2);

  // Llamando al function (de dos formas distintas)
  Exec Sql
    SET :sum = JOMUMA1.SUMA_AND_B(2, 3);

  Exec Sql
    SELECT JOMUMA1.SUMA_AND_B(2, 3)
      into :sum
    FROM SYSIBM.SYSDUMMY1;
  
  snd-msg %char(sum) %target(*self:2);  

end-proc;
