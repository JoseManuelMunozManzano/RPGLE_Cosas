**FREE
//*****************************************************************************
// SRVUTIL
//     Service Program sencillote
//     La idea es que se llame desde procedimientos almacenados
//*****************************************************************************
// Compilación
//  CRTRPGMOD MODULE(JOMUMA1/SRVUTIL) DBGVIEW(*SOURCE) SRCFILE(JOMUMA1/QRPGLESRC)
//  CRTSRVPGM SRVPGM(JOMUMA1/SRVUTIL) EXPORT(*SRCFILE) ACTGRP(*CALLER)
//*****************************************************************************
ctl-opt nomain;

/copy qrpglesrc,srvutil_h

//-----------------------------------------------------------------------------
// SRVUTIL_Sum_A_And_B
//   Esta función devuelve la suma de dos números packed
//-----------------------------------------------------------------------------
dcl-proc SRVUTIL_Sum_A_And_B export;

  dcl-pi *n packed(15:5);
    a packed(15:5) const;
    b packed(15:5) const;
  end-pi;

  dcl-s c packed(15:5) inz;

  c = a + b;

  snd-msg %char(c);

  return c;

end-proc;

//-----------------------------------------------------------------------------
// SRVUTIL_Sum_A_And_B_2
// Este procedure devuelve la suma de dos números packed en un tercer parámetro
//-----------------------------------------------------------------------------
dcl-proc SRVUTIL_Sum_A_And_B_2 export;

  dcl-pi *n;
    a packed(15:5) const;
    b packed(15:5) const;
    c packed(15:5);
  end-pi;

  c = a + b;

end-proc;
