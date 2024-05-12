**FREE
//***************************************************************************
// VARSIZELEN
// Quita la basura cuando en un parámetro de entrada de longitud 80
// se le pasan menos caracteres
//***************************************************************************
ctl-opt main(main);

dcl-proc main;

  dcl-pi *n;
    i_varsize char(80) const options(*varsize);
    w_varsize char(80);
  end-pi;

  dcl-s tamano zoned(2:0) inz;

  tamano = %size(%trim(i_varsize));

  w_varsize = %subst(i_varsize:1:%len(%trim(i_varsize)));

  w_varsize = %trim(w_varsize) + ' hola';

end-proc;
