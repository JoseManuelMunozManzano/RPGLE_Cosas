**FREE
//*****************************************************************************
// ISINDEBUG
//     Ejemplo de programa en el que sabemos si estamos o no en un debug
//*****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

// Necesario para saber si estamos o no haciendo debug
/copy qsysinc/qrpglesrc,qusec

//*****************************************************************************
// PROCESO PRINCIPAL
//*****************************************************************************
dcl-proc main;

  dcl-s user char(10) inz(*user);
  dcl-s word char(50) inz('Hello');

  if user = 'JOMUMA' and Is_Debugger_On();
    word = 'racecar';
  endif;

  if Word_Is_Equal_Reversed(word);
    snd-msg %trim(word) + ' is equal reversed.';
  else;
    snd-msg %trim(word) + ' is NOT equal reversed.';
  endif;

end-proc;

//-----------------------------------------------------------------------------
// La palabra se lee igual del derecho que del revés
//-----------------------------------------------------------------------------
dcl-proc Word_Is_Equal_Reversed;

  dcl-pi *n ind;
    word char(50) const;
  end-pi;

  dcl-s reversed char(50) inz;
  dcl-s x zoned(2:0) inz;
  dcl-s z zoned(2:0) inz;

  x = 1;
  for z = 50 downto 1;
    %subst(reversed:z:1) = %subst(word:x:1);
    x += 1;
  endfor;

  return %trim(word) = %trim(reversed);

end-proc;

//-----------------------------------------------------------------------------
// Para saber si estamos en un debug
//-----------------------------------------------------------------------------
dcl-proc Is_Debugger_On;

  dcl-pi *n ind;
  end-pi;

  dcl-pr Retrieve_Debug_Attribute extproc('QteRetrieveDebugAttribute');
    *n char(10) const;
    *n char(10) const;
    *n likeds(QUSEC);
  end-pr;

  QUSBPRV = %size(QUSEC);

  Retrieve_Debug_Attribute('*UPDPROD':'':QUSEC);

  if QUSBAVL > 0 and QUSEI = 'CPF9541';
    return *off;
  endif;

  // Estoy en un debug
  return *on;

end-proc;
