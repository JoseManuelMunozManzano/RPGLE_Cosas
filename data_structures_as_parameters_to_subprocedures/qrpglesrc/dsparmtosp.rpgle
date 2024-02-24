**FREE
//*******************************************************************
// DSPARMTOSP
//
// Pasando estructuras de datos como parámetros a suprocedures
//
// COMPILACION: 14
//*******************************************************************
ctl-opt main(dsparmtosp) dftactgrp(*no) actgrp(*caller);

dcl-ds dsStructure_t qualified template;
  field1 varchar(20);
  field2 zoned(5:0) inz;
  field3 varchar(10);
end-ds;

//*******************************************************************
// PRINCIPAL
//*******************************************************************
dcl-proc dsparmtosp;

  dcl-ds dsStructure1 likeds(dsStructure_t) dim(1000) inz(*likeds);

  // Usando una ds *auto (tamaño variable)
  // Hay que llamar al subprocedure con la ds y con el número de elementos que tiene.
  dcl-ds dsStructure2 likeds(dsStructure_t) dim(*auto:1000) inz(*likeds);
  dcl-ds dsStructure3 likeds(dsStructure_t) dim(*auto:1000) inz(*likeds);
  dcl-ds dsStructure4 likeds(dsStructure_t) dim(*auto:1000) inz(*likeds);

  dcl-s elements zoned(4:0) inz;

  clear dsStructure1;

  // Caso 1
  // El caso típico en el que pasamos la ds completa para que se haga alguna operación
  snd-msg %char(subproc1(dsStructure1)) %target(*self:2);

  // Caso 2
  // Pasamos una ds *auto para que se haga una operación sobre algún campo
  //
  // Inicializamos la ds *auto
  // Llamando al subprocedure con el número de elementos pasado por valor, porque
  // no lo voy a modificar.
  // Si no se pasa el número de elementos, como en la ds todos están vacíos, el campo field2
  // que es numérico fallará al sumarse.
  %elem(dsStructure2) = 0;
  snd-msg %char(subproc2(dsStructure2:%elem(dsStructure2))) %target(*self:2);

  // Caso 3
  // Si quiero modificar la ds tengo que pasarla por referencia, usando la
  // opción *varsize en el caso de ds con tamaño variable en el subprocedure.
  //
  // Llamamos al subprocedure y luego indicamos el número de elementos que hay,
  // manteniendo la data.
  // Si no se pasa el número de elementos, como en la ds todos están vacíos, el campo field2
  // que es numérico fallará al sumarse.
  %elem(dsStructure3) = 0;
  elements = 0;
  subproc3(dsStructure3:elements);
  %elem(dsStructure3:*keep) = elements;

  // Caso 4
  // Queremos que el subprocedure nos devuelva la ds.
  //
  // Pasamos el número de elementos que queremos que tenga la ds.
  // A la vuelta del subprocedure es muy importante establecer de nuevo el número de elementos,
  // indicando que se mantiene la data.
  // Si no se hace, no podremos acceder a los diferentes registros de la ds
  elements = 1000;
  dsStructure4 = subproc4(elements);
  %elem(dsStructure4:*keep) = 1000;

end-proc;

//-------------------------------------------------------------------
// Suma de todos los field2
//-------------------------------------------------------------------
dcl-proc subproc1;

  dcl-pi *n zoned(10:0);
    dsStructure likeds(dsStructure_t) dim(1000) const;
  end-pi;

  dcl-s z zoned(4:0) inz;
  dcl-s sum zoned(10:0) inz;

  for z = 1 to %elem(dsStructure);
    sum += dsStructure(z).field2;
  endfor;

  return sum;

end-proc;

//-------------------------------------------------------------------
// Suma de todos los field2, pero para una ds *auto
//-------------------------------------------------------------------
dcl-proc subproc2;

  dcl-pi *n zoned(10:0);
    dsStructure likeds(dsStructure_t) dim(1000) const;
    elements zoned(4:0) const;
  end-pi;

  dcl-s z zoned(4:0) inz;
  dcl-s sum zoned(10:0) inz;

  for z = 1 to elements;
    sum += dsStructure(z).field2;
  endfor;

  return sum;

end-proc;

//-------------------------------------------------------------------
// Rellenar los valores de una ds dinámica
//-------------------------------------------------------------------
dcl-proc subproc3;

  dcl-pi *n;
    dsStructure likeds(dsStructure_t) dim(1000) options(*varsize);
    elements zoned(4:0);
  end-pi;

  for elements = 1 to 1000;
    dsStructure(elements).field2 = elements;
  endfor;

end-proc;

//-------------------------------------------------------------------
// Devolver una ds
//-------------------------------------------------------------------
dcl-proc subproc4;

  dcl-pi *n likeds(dsStructure_t) dim(1000);
    elements zoned(4:0) const;
  end-pi;

  dcl-ds dsStructure likeds(dsStructure_t) dim(*auto:1000) inz(*likeds);
  dcl-s z zoned(4:0) inz;

  // Inicializamos la ds
  %elem(dsStructure) = 0;
  
  for z = 1 to elements;
    dsStructure(z).field2 = z;
  endfor;

  return dsStructure;

end-proc;
