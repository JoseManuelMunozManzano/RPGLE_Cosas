**FREE
 //************************************************
 // ORDPRC1 - CALLING PROGRAM
 //           IT WORKS WITH ORDPRC2.RPGLE 
 // TO COMPILE: 14
 // TO EXECUTE: CALL ORDPRC1
 //************************************************
  ctl-opt dftactgrp(*no) actgrp(*new);

  dcl-f ordprfm workstn;

  dcl-pr Obtener_Nombre_Producto extpgm('ORDPRC2');
    *n char(3) const;
    *n char(15);
    *n char(60);
  end-pr;

  //************************************************
  // MAIN PROCESS
  //************************************************

    F1NUMP = *blanks;
    F1NOMP = *blanks;
    F1ERR = *blanks;
    exfmt FMT01;

    dow not *inkc;
      F1ERR = *blanks;
      callP Obtener_Nombre_Producto(F1NUMP:F1NOMP:F1ERR);
      exfmt FMT01;
    enddo;

    *inlr = *on;
