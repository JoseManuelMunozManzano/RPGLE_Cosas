**FREE
 //************************************************
 // ORDSRVC1 - CALLING SRVPGM ORDSRV
 //
 // COMPILING THE SERVICE PROGRAM:
 //    CRTRPGMOD MODULE(MyLib/ORDSRVC1) DBGVIEW(*SOURCE) SRCFILE(MyLib/QRPGLESRC)
 // CREATING THE PROGRAM:
 //    CRTPGM PGM(MyLib/ORDSRVC1) BNDSRVPGM(ORDSRV) ACTGRP(*NEW)
 //************************************************
  dcl-f ordprfm workstn;

  dcl-pr Obtener_Nombre_Producto;
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
