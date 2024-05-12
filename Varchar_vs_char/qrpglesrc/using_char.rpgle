**FREE
//*****************************************************************************
// USING_CHAR
//     Ejemplo de uso con CHAR (no recomendado)
//     Vemos que tenemos que tirar por todos lados del %trim
//     Espacio en memoria malgastado
//*****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

//*****************************************************************************
// PROCESO PRINCIPAL
//*****************************************************************************
dcl-proc main;

  dcl-s string char(100) inz;
  dcl-s a char(10) inz;
  dcl-s b char(10) inz;
  dcl-s c char(10) inz;

  a = 'Dis';
  b = 'con';
  c = 'nected';

  string = %trim(a) + %trim(b) + %trim(c);
  snd-msg string + ' ' + %char(%len(string));

  string = %trim(string) + %trim(Get_Data(a:b));
  snd-msg string;

end-proc;

//-----------------------------------------------------------------------------
// Get_Data
//-----------------------------------------------------------------------------
dcl-proc Get_Data;

  dcl-pi *n char(100);
    a char(100) const;
    b char(100) const;
  end-pi;

  return %trim(a) + %trim(b);
  
end-proc;
