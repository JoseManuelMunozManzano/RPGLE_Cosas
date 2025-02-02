**FREE
// ****************************************************************************
// NULLEX
//     Ejemplo de uso de NULL en RPG
// ****************************************************************************
// En el Spec H activamos la posibilidad de usar NULL en el programa
// con alwnull(*usrctl)
ctl-opt main(main) alwnull(*usrctl) dftactgrp(*no) actgrp(*new);

// En un template no se puede indicar nullind
dcl-s name_t varchar(100) template;

// -----------------------------------------------------------------------------
// PROCESO PRINCIPAL
// -----------------------------------------------------------------------------
dcl-proc main;

  dcl-f nullexpf usage(*input:*output) 
          extdesc('JOMUMA1/NULLEXPF')
          extfile(*extdesc)
          keyed;

  dcl-ds dsNullExPf likerec(rnullexpf);

  // Y, ahora, en la variable, se indica nullind
  dcl-s nameOfCustomer like(name_t) nullind;

  // Asignamos un valor correcto a nuestra variable
  nameOfCustomer = 'John';

  // Pero aquí indicamos que nuestra variable es null
  %nullind(nameOfCustomer) = *on;
  writeName(nameOfCustomer);

  // Aquí indicamos que nuestra variable ya no es null
  %nullind(nameOfCustomer) = *off;
  writeName(nameOfCustomer);

  // Creamos un registro donde todos los campos tienes valores
  dsNullExPf.field1 = 1;
  dsNullExPf.field2 = 'Second field';
  dsNullExPf.field3 = 'Third field';
  write rnullexpf dsNullExPf;

  // Creamos un registro donde algún campo tiene un valor null
  clear dsNullExPf;
  dsNullExPf.field1 = 2;
  dsNullExPf.field2 = 'Second field';
  %nullind(dsNullExPf.field3) = *on;
  write rnullexpf dsNullExPf;

  // Lectura de un campo null
  chain(n) 2 rNullExPf dsNullExPf;
  if %found;
    if %nullind(dsNullExPf.field3);
      snd-msg 'Field3 is null';
    else;
      snd-msg 'Field3 is ' + dsNullExPf.field3;
    endif;
  endif;
  
end-proc;

// -----------------------------------------------------------------------------
// PROCESO PRINCIPAL
// -----------------------------------------------------------------------------
dcl-proc writeName;

  dcl-pi *n;
    name like(name_t) const options(*nullind);
  end-pi;

  // Validar si la variable tiene el valor null. Devuelve *on o *off
  if %nullind(name);
    snd-msg 'The customer has no name';
  else;
    snd-msg 'The name of the customer is ' + name;
  endif;

end-proc;
