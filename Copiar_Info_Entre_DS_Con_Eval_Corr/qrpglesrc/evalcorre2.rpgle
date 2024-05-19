**FREE
// *****************************************************************************
// EVALCORRE2
//     Ejemplo de copia de una estructura a otra usando EVAL-CORR
// *****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

// *****************************************************************************
// PROCESO PRINCIPAL
// *****************************************************************************
dcl-proc main;

  dcl-f ajedrecFm workstn
                  extdesc('JOMUMA1/AJEDRECFM')
                  sfile(SF01:nrr1)
                  indds(indicators);

  dcl-s nrr1 zoned(4:0) inz;

  dcl-f ajedreci usage(*input)
                 extdesc('JOMUMA1/AJEDRECI')
                 extfile(*extdesc)
                 keyed;

  dcl-ds indicators;
    endOfPgm ind pos(3);
    sflDspCtl ind pos(30);
    sflDsp ind pos(31);
    sflClr ind pos(32);
    sflEnd ind pos(80);
  end-ds;

  dcl-ds dsAjedreci likerec(RAJEDRECI);
  dcl-ds dsHead likerec(CF01:*all);
  dcl-ds dsSfl likerec(SF01:*all);
  dcl-ds dsFooter likerec(CF01P:*all);

  // Limpiando el SFL
  nrr1 = 0;
  sflClr = *on;
  sflDspCtl = *on;
  sflDsp = *off;

  // Tenemos que indicar siempre una DS porque estamos dentro de un procedure.
  Write CF01 dsHead;

  sflClr = *off;
  sflDspCtl = *on;

  nrr1 = 0;
  dsHead.rcdnr1 = 1;

  // Rellenar el SFL con data
  setll *loval ajedreci;
  read ajedreci dsAjedreci;
  dow not %eof(ajedreci);

    // Los campos del SFL deben tener los mismos nombres que el fichero
    // Ajedreci y tipos compatibles.
    eval-corr dsSfl = dsAjedreci;
    sflDsp = *on;
    nrr1 += 1;

    write SF01 dsSfl;

    read ajedreci dsAjedreci;
  enddo;

  sflEnd = *on;

  // Mostrar el SFL

  dow not endOfPgm;
    if nrr1 > 0;
      write CF01P dsFooter;
      exfmt CF01 dsHead;
    endif;
  enddo;

end-proc;
