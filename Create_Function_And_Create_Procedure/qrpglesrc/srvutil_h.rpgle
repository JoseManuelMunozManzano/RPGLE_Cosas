**FREE
//*****************************************************************************
// SRVUTIL_H
//     Copy File del programa de servicio SRVUTIL
//*****************************************************************************
dcl-pr SRVUTIL_Sum_A_And_B packed(15:5);
  a packed(15:5) const;
  b packed(15:5) const;
end-pr;

dcl-pr SRVUTIL_Sum_A_And_B_2;
  a packed(15:5) const;
  b packed(15:5) const;
  c packed(15:5);
end-pr;
