**FREE
 //************************************************
 // ORDSRVF1 - CALLING SRVPGM ORDSRV
 // FUNCTION CALLS AND RETURN A VALUE
 //
 // COMPILING THE SERVICE PROGRAM:
 //    CRTRPGMOD MODULE(MyLib/ORDSRVC1) DBGVIEW(*SOURCE) SRCFILE(MyLib/QRPGLESRC)
 // CREATING THE PROGRAM:
 //    CRTPGM PGM(MyLib/ORDSRVF1) BNDSRVPGM(ORDSRV) ACTGRP(*NEW)
 //************************************************
  dcl-f ordprfm workstn;

  dcl-pr Obtener_Nombre_Producto_Funcion char(15);
    *n char(3) const;
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
      F1NOMP = Obtener_Nombre_Producto_Funcion(F1NUMP:F1ERR);
      exfmt FMT01;
    enddo;

    *inlr = *on;
