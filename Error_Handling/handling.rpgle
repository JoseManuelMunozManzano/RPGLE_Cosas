**free
//***********************************************************
// Manejo de errores
// Si esperamos cualquier tipo de error
//***********************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*new);

dcl-proc main;

  dcl-s gAmount zoned(13:2) inz;
  dcl-s gDivisor zoned(13:2) inz;

  gAmount = 100;
  gDivisor = 0;

  Cualquier_Tipo_Error(gAmount:gDivisor);
  Tipos_Concretos_De_Error(gAmount:gDivisor);
  Mensajes_Especificos();
  Nuestros_Errores();

end-proc;

//-----------------------------------------------------------
// Esperamos cualquier tipo de error y lo gestionamos
//-----------------------------------------------------------
dcl-proc Cualquier_Tipo_Error;

  dcl-pi *n;
    gAmount zoned(13:2) const;
    gDivisor zoned(13:2) const;
  end-pi;

  dcl-s gResult zoned(13:2) inz;

  monitor;
    gResult = gAmount / gDivisor;
  on-error;
    select;
      when %status = 00102;
        snd-msg 'Division by zero detected';
        gResult = 0;
        snd-msg 'Division failed, result set to zero';
      when %status = 00121;
        snd-msg 'Array index out of bounds';
      other;
        snd-msg 'Unexpected error: ' + %char(%status);
    endsl;
  endmon;

  snd-msg 'Division = ' + %editc(gResult:'4');

end-proc;

//-----------------------------------------------------------
// Tipos concretos de error
//-----------------------------------------------------------
dcl-proc Tipos_Concretos_De_Error;

  dcl-pi *n;
    gAmount zoned(13:2) const;
    gDivisor zoned(13:2) const;
  end-pi;

  dcl-s gResult zoned(13:2) inz;

  monitor;
    gResult = gAmount / gDivisor;
  on-error 00102;
    snd-msg 'Division by zero detected';
    gResult = 0;
    snd-msg 'Division failed, result set to zero';
  on-error 00121;
    snd-msg 'Array index out of bounds';
  endmon;

  snd-msg 'Division = ' + %editc(gResult:'4');

end-proc;

//-----------------------------------------------------------
// Mensajes específicos
//-----------------------------------------------------------
dcl-proc Mensajes_Especificos;

  dcl-pr QCMDEXC extpgm('QCMDEXC');
    *n char(100) const;
    *n packed(15:5) const;
  end-pr;

  dcl-s gResult zoned(13:2) inz;
  dcl-s pCmd char(100) inz;
  dcl-s pCmdLen packed(15:5) inz;

  // Comprobamos un fichero que no existe
  pCmd = 'CHKOBJ OBJ(JOMUMA1/XXX) OBJTYPE(*FILE)';

  // on-error reacciona a errores RPG en tiempo de ejecución
  // on-excp reacciona a  mensajes de escape específicos.
  //    Es el mismo tipo de mensaje que se comprueba en CL con MONMSG
  //    Muy útiles cuando llamamos APIs u otros programas y queremos
  //    reaccionar a un ID de mensaje particular.
  monitor;
    QCMDEXC(pCmd:%len(%trim(pCmd)));
  on-excp 'CPF9801';
    snd-msg 'The file was not found';
  on-excp 'CPF9810':'CPF0000';
    snd-msg 'The library was not found';
  endmon;

end-proc;

//-----------------------------------------------------------
// Nuestros errores
//-----------------------------------------------------------
dcl-proc Nuestros_Errores;

  dcl-s gName varchar(30) inz;

// Podemos crear nuestros propios procedures que reporten errores
//    usando snd-msg *escape (ver getCustomerName)
// Quien llame a ese procedure puede recogerlos con on-excp 'CPF9898'
//    Ese código CPF9898 es el ID de mensaje por defecto usado por
//    snd-msg *escape cuando nosostros no especificamos uno.

  monitor;
    gName = getCustomerName(777);
  on-excp 'CPF9898';
    gName = 'Unknown';
    snd-msg 'Customer was not found, using default name';
  endmon;

  snd-msg 'Customer name: ' + gName;

end-proc;

//-----------------------------------------------------------
// Obtener cliente devuelve una excepción recogida por
// Nuestros_Errores
//-----------------------------------------------------------
dcl-proc getCustomerName;

  dcl-pi *n varchar(30);
    pCustomerNumber packed(7) const;
  end-pi;

  dcl-s pName varchar(30) inz;

  // ... código que busca el nombre del cliente.
  // No lo encuentra y devolvemos un mensaje de escape.
  snd-msg *escape 'Customer not found';

  return pName;


end-proc;