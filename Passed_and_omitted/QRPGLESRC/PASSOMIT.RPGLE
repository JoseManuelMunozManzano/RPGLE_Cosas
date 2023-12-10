**free
//*****************************************************************************
// %PASSED y %OMITTED
//
// Muestra las nuevas operaciones %PASSED y %OMITTED
//*****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

dcl-proc main;

  snd-msg '*OMIT';
  procedure(*omit);

  snd-msg 'A';
  procedure('A');

  snd-msg 'A:B';
  procedure('A':'B');

  snd-msg '*OMIT:B:*OMIT';
  procedure(*omit:'B':*omit);

end-proc;

dcl-proc procedure;
  dcl-pi *n;
    parm1 char(1) const options(*omit);   // Se puede pasar valor o *omit
    parm2 char(1) const options(*nopass); // Se puede pasar valor o ignorarlo
    parm3 char(1) const options(*nopass:*omit);  // Se puede pasar valor, *omit, o ignorarlo
  end-pi;

  //! Forma antigua
  // Comprueba si el número de parámetros recibidos es al menos 1 y si es omitted o no
  if %parms >= 1;
    if %addr(parm1) = *NULL;
      // omitted
    else;
      // passed
    endif;
  endif;

  //! Forma nueva
  // Con esto sabemos si lo hemos pasado o lo hemos ignorado
  if %passed(parm1);
    snd-msg 'PARM1 passed';
  // Con esto sabemos si es omitted o tiene un valor 
  elseif %omitted(parm1);
    snd-msg 'PARM1 omitted';
  else;
    snd-msg 'PARM1 not available';
  endif;

  if %passed(parm2);
    snd-msg 'PARM2 passed';
  else;
    snd-msg 'PARM2 not available';
  endif;

  if %passed(parm3);
    snd-msg 'PARM3 passed';
  elseif %omitted(parm3);
    snd-msg 'PARM3 omitted';
  else;
    snd-msg 'PARM3 not available';
  endif;

end-proc;
