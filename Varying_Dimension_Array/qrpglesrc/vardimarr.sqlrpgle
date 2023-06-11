**free
// ****************************************************************************
//  vardimarr
//  Array de Dimensión Variable
// ****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

dcl-ds dsArray_t extname('JOMUMA1/AJEDRECI') qualified template;
end-ds;

// ****************************************************************************
// PROCESO PRINCIPAL
// ****************************************************************************
dcl-proc main;

  dcl-ds dsArray likeds(dsArray_t) dim(*auto:1000);
  dcl-s $i zoned(5:0) inz;

  // Para inicializar un array de dimensión variable hay que usar %elem.
  // No funciona clear.
  %elem(dsArray) = 0;

  $i = Load_Array_With_Filters(dsArray:'ELO >= 2800':'OR':'FEDERACION LIKE ''U%''');

  // IMPORTANTE: Indicar el número de elementos que tendrá el array.
  // *keep se usa para mantener los valores de los elementos llenados en el subprocedure.
  // Sin el se inicializarían los valores.
  if $i > 0;
    %elem(dsArray:*keep) = $i;
  endif;

  for $i = 1 to %elem(dsArray);
    snd-msg %trim(dsArray($i).nombre) + ' ' + %trim(dsArray($i).apellidos) + ' ' +
      ' ' + %trim(dsArray($i).federacion) + ' ' + %char(dsArray($i).elo);
  endfor;

end-proc;

// ----------------------------------------------------------------------------
// Cargar el array con filtros
// ----------------------------------------------------------------------------
dcl-proc Load_Array_With_Filters;

  dcl-pi *n zoned(5:0);
    i_o_dsArray likeds(dsArray_t) dim(1000) options(*varsize);
    in_filter1 varchar(100) options(*nopass) const;
    in_andOr char(3) options(*nopass) const;
    in_filter2 varchar(100) options(*nopass) const;
  end-pi;

  dcl-s sqlStm varchar(1000) inz;
  dcl-s rows int(10) inz(1000);
  dcl-s elements zoned(5:0) inz;

  sqlStm = 'SELECT * FROM JOMUMA1.AJEDRECISTAS';

  if %parms >= %parmnum(in_filter1);
    sqlStm = %concat(' ' : sqlStm : 'WHERE' : in_filter1);
  endif;

  if %parms > %parmnum(in_andOr) and %parms <= %parmnum(in_filter2);
    sqlStm = %concat(' ' : sqlStm : in_andOr : in_filter2);
  endif;

  exec sql prepare s1 from :sqlStm;
  exec sql declare c1 cursor for s1;
  exec sql open c1;

  exec sql fetch c1 for :rows rows into :i_o_dsArray;
  exec sql get diagnostics :elements = ROW_COUNT;

  exec sql close c1;

  return elements;

end-proc;
