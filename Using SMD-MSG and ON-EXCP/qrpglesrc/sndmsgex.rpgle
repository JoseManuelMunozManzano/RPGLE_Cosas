**FREE
// *****************************************************************************
// SNDMSGEX
//     Ejemplo de uso de SND-MSG y ON-EXCP
//     Como utilizar SND-MSG para mandar mensajes de error a otros procedures
// *****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

// *****************************************************************************
// PROCESO PRINCIPAL
// *****************************************************************************
dcl-proc main;

  // Para recuperar un mensaje monitorizamos el procedure.
  // En el on-excp indicamos el nombre del mensaje esperado si falla.
  // Ahí hacemos lo que tengamos que hacer.
  // Mantenemos on-error para errores generales no recogidos por foo()
  monitor;
    foo();
  on-excp 'MSG0001';
    snd-msg 'Error 1';
  on-error;
    snd-msg 'Error general';
  endmon;

end-proc;

// ----------------------------------------------------------------------------
// foo - Es un procedure que provoca y devuelve un error
// ----------------------------------------------------------------------------
dcl-proc foo;

  dcl-s a zoned(2:0) inz;
  dcl-s b zoned(2:0) inz;
  dcl-s c zoned(2:0) inz;

  monitor;
    // Dividimos entre 0
    c = a / b;
  on-error;
    // Indicamos el id del mensaje y el nombre del fichero de mensaje.
    // Indicamos que el target va a ser el procedure llamador (main en este caso)
    snd-msg *ESCAPE %msg('MSG0001':'MSGFJM') %target(*caller);
  endmon;

end-proc;
