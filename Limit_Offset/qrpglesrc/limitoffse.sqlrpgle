**FREE
//*******************************************************************
// LIMITOFFSE
//
// Recuperar 100 registros a partir de un offset (5000)
//*******************************************************************
// Con SQL sería:
//    select * from jomuma1.ajedreci limit 100 offset 4999;
//*******************************************************************
// COMPILACIÓN: 14
//*******************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

dcl-ds dsPlayers_t qualified template;
  id zoned(5:0);
  playerName char(50);
  playerLastName char(50);
  playerFederation char(50);
  ELO zoned(4:0);
end-ds;

//*******************************************************************
// MAIN
//*******************************************************************
dcl-proc main;

  dcl-ds dsPlayers likeds(dsPlayers_t) dim(*auto:100) inz(*likeds);
  dcl-s number zoned(3:0) inz;

  number = getData(0:dsPlayers);
  %elem(dsPlayers:*keep) = number;
  snd-msg %char(number) + ' elements retrieved';

  number = getData(9997:dsPlayers);
  %elem(dsPlayers:*keep) = number;
  snd-msg %char(number) + ' elements retrieved';

end-proc;

//-------------------------------------------------------------------
// Obtener la data
// Devuelve el número de elementos devueltos
//-------------------------------------------------------------------
dcl-proc getData;

  dcl-pi *n zoned(3:0);
    offset zoned(5:0) const;
    dsPlayers likeds(dsPlayers_t) dim(100) options(*varsize);
  end-pi;

  dcl-s maxRows zoned(3:0) inz(100);
  dcl-s retrieved zoned(3:0) inz(100);

  exec sql declare c1 cursor for
    select * 
    from jomuma1.ajedreci
    order by id
    limit 100
    offset :offset;
  
  exec sql open c1;

  exec sql fetch c1 for :maxRows rows into :dsPlayers;

  exec sql
    get diagnostics :retrieved = ROW_COUNT;

  exec sql close c1;

  return retrieved;

end-proc;
