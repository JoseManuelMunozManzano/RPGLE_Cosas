**FREE
//*****************************************************************************
// ONEXIT_EX
//     Ejemplo de uso de MONITOR y ON-EXIT
//*****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

//*****************************************************************************
// PROCESO PRINCIPAL
//*****************************************************************************
dcl-proc main;

  Exec Sql
    SET OPTION COMMIT = *NONE;

  snd-msg 'MAIN procedure';

  // Usando monitor, el programa ejecutará calculation todas las veces, incluso
  // cuando se ejecute el on-error
  snd-msg %char(calculation(1:2));
  snd-msg %char(calculation(5:0));
  snd-msg %char(calculation(4:2));

end-proc;

//-----------------------------------------------------------------------------
// calculation
//-----------------------------------------------------------------------------
dcl-proc calculation;

  dcl-pi *n zoned(5:3);
    num1 zoned(2) const;
    num2 zoned(2) const;
  end-pi;

  dcl-s calculationError ind inz;
  dcl-s result zoned(5:3) inz;

  monitor;
    result = num1 / num2;
  on-error;
    snd-msg 'ERROR detected in "calculation"';
    return -1;
  endmon;

  return result;

// Si algo anómalo, como que se cierre la sesión ocurre en mitad de la ejecución,
// el indicador se pondrá a *on y se ejecutará la parte del if.
  on-exit calculationError;

    if calculationError;
      snd-msg 'FATAL ERROR detected in "calculation"';
      Exec Sql
        INSERT INTO JOMUMA1.AJEDRECI (NOMBRE, APELLIDOS, FEDERACION, ELO)
          VALUES('ERROR', 'CERRADO CON X', 'UN PRENDA', -1);
      return -1;
    endif;

end-proc;
