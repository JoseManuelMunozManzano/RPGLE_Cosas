**FREE
//*******************************************************************
// T_LISTAGG
//
// TEST DE LA FUNCION SQL LISTAGG
//*******************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

dcl-ds dsAjedreci_t qualified template;
  federacion char(20) inz;
  federacionList varchar(100);
end-ds;

dcl-proc main;
  dcl-s z zoned(5:0) inz;
  dcl-ds dsAjedreci likeds(dsAjedreci_t) dim(*auto:100) inz(*likeds);

  %elem(dsAjedreci) = 0;

  exec sql
    declare c1 cursor for
    SELECT FEDERACION, LISTAGG(ID, ', ') WITHIN GROUP (ORDER BY ID ASC) AS "AJEDRECISTAS"
    FROM JOMUMA1.AJEDRECI
    GROUP BY FEDERACION;
  
  exec sql open c1;

  exec sql fetch c1 for 100 rows into :dsAjedreci;

  if sqlStt <> '00000';
    snd-msg 'Error al obtener datos de la tabla' %target(*self:2);
    return;
  endif;

  exec sql close c1;

  for z = 1 to %elem(dsAjedreci);
    snd-msg %char(dsAjedreci(z).federacionList);
  endfor;

end-proc;
