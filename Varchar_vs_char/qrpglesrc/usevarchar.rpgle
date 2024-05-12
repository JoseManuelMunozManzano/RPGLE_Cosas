**FREE
//*****************************************************************************
// USEVARCHAR
//     Ejemplo usando VARCHAR (recomendado)
//     Más legible, menos consumo de memoria y menos uso de %trim()
//*****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

//*****************************************************************************
// PROCESO PRINCIPAL
//*****************************************************************************
dcl-proc main;

  dcl-s string varchar(100) inz;
  dcl-s a varchar(10) inz;
  dcl-s b varchar(10) inz;
  dcl-s c varchar(10) inz;

  a = 'Dis';
  b = 'con';
  c = 'nected';

  string = a + b + c;
  snd-msg string + ' ' + %char(%len(string));

  string += Get_Data(a:b);
  snd-msg string;

end-proc;

//-----------------------------------------------------------------------------
// Get_Data
//-----------------------------------------------------------------------------
dcl-proc Get_Data;

  dcl-pi *n varchar(100);
    a varchar(100) const;
    b varchar(100) const;
  end-pi;

  return a + b;
  
end-proc;
