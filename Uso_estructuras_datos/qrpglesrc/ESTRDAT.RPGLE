**FREE
// ****************************************************************************
// ESTRDAT
//     Ejemplo de uso de Estructuras de datos
// ****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

// ----------------------------------------------------------------------------
// PROCESO PRINCIPAL
// ----------------------------------------------------------------------------
dcl-proc main;

  Array_Dinamico();
  Estructura_Datos_Sin_Nombre();
  Estructura_Calificada();
  Division_Manual();
  Array_Posicional();
  Estructura_Anidada();
  Estructura_Externa_Desde_Fichero_Fisico();  
  Estructura_Occurs();  // Antiguo y no recomendado

end-proc;

// ----------------------------------------------------------------------------
// ARRAY DINAMICO
// ----------------------------------------------------------------------------
dcl-proc Array_Dinamico;

  // ARRAY dinámico con un máximo de 10 elementos.
  dcl-s nombres char(50) dim(*auto:10) inz;
  dcl-s ii zoned(2:0) inz;

  %elem(nombres) = 0;

  nombres(*next) = 'José Manuel';
  nombres(*next) = 'Adriana';
  nombres(*next) = 'Tania';

  for ii = 1 to %elem(names);
    snd-msg nombres(ii);
  endfor;

end-proc;

// ----------------------------------------------------------------------------
// ESTRUCTURA DE DATOS SIN NOMBRE
// ----------------------------------------------------------------------------
dcl-proc Estructura_Datos_Sin_Nombre;

  // Útil cuando solo queremos agrupar datos
  dcl-ds *n inz;
    nombre char(30);
    direccion char(50);
    edad zoned(3:0);
  end-ds;

  nombre = 'Juan';
  direccion = 'Calle Pepe 1';
  edad = 27;

end-proc;

// ----------------------------------------------------------------------------
// ESTRUCTURA CALIFICADA
// ----------------------------------------------------------------------------
dcl-proc Estructura_Calificada;

  // Para organizar campos bajo un nombre común
  dcl-ds producto qualified inz;
    id zoned(5:0);
    descripcion char(30);
    precio zoned(7:2);
    tamano char(2) dim(10); // Esta dimensión debe ser fija
  end-ds;

  producto.id = 1;
  producto.descripcion= 'Camiseta';
  producto.precio = 12.95;
  producto.tamano(1) = 'M';
  producto.tamano(2) = 'L';
  producto.tamano(3) = 'XS';

end-proc;

// ----------------------------------------------------------------------------
// DIVISION MANUAL
// ----------------------------------------------------------------------------
dcl-proc Division_Manual;

  // Útil para dividir y acceder a distintas partes de un campo.
  // No nos hará falta usar %substr
  dcl-ds *n inz;
    multicampo char(1000);    // Empieza en la posición 1
    sub1 char(10) pos(1);     // Las primeras 10 posiciones de multicampo
    sub2 char(10) post(11);   // Desde la posición 11 y llega a la 20
    sub3 char(10) post(21);   // Desde la posición 21 y llega a la 30
  end-ds;

  multicampo = 'José Luís C/Pepe 1  28061';

  snd-msg sub1; // José Luís
  snd-msg sub2; // C/Pepe 1
  snd-msg sub3; // 28061

end-proc;

// ----------------------------------------------------------------------------
// ARRAY POSICIONAL
// ----------------------------------------------------------------------------
dcl-proc Array_Posicional;

  // Es la misma idea que la Division Manual.
  // En este caso dividimos buffer en 20 entradas, cada una de 50 posiciones.
  dcl-ds *n inz;
    buffer char(1000);
    entradas char(50) dim(20) pos(1);
  end-ds;

  buffer = 'Id fugiat deserunt consequat reprehenderit eiusmod eu labore nostrud ullamco. Non Lorem nostrud ut consequat veniam consectetur sunt. Eu in eiusmod laborum voluptate voluptate. Cupidatat ea do fugiat nisi sit et commodo ipsum proident mollit aliqua occaecat culpa id.'

  snd-msg entries(1);
  snd-msg entries(2);
  snd-msg entries(3);

end-proc;

// ----------------------------------------------------------------------------
// ESTRUCTURA ANIDADA
// ----------------------------------------------------------------------------
dcl-proc Estructura_Anidada;

  // La idea es crear jerarquías de datos relacionados.
  dcl-ds dsFactura qualified inz;
    numero zoned(2:0);
    dcl-ds dsCliente dim(10) inz;
      nombre char(30);
      ciudad char(30);
    end-ds;
  end-ds;

  dsFactura.numero = 1;
  dsFactura.dsCliente(1).nombre = 'Marina';
  dsFactura.dsCliente(1).ciudad = 'Almería';

end-proc;

// ----------------------------------------------------------------------------
// ESTRUCTURA EXTERNA CREADA A PARTIR DE UN FICHERO FISICO
// ----------------------------------------------------------------------------
dcl-proc Estructura_Externa_Desde_Fichero_Fisico;

  dcl-f AJEDRECI usage(*input) keyed;
  
  // Se usa EXTNAME o LIKEREC
  // Usando EXTNAME
  // Esta ds tendrá la misma estructura (mismos campos y tipos de datos) que el fichero declarado.
  dcl-ds dsAjedrecista extname('AJEDRECI') end-ds;

  // Usando LIKEREC
  // Utiliza el formato de registro.
  dcl-ds dsAjedrecista2 likerec('RAJEDRECI');

  read AJEDRECI dsAjedrecista;
  if not %eof;
    snd-msg dsAjedrecista.nombre;
    snd-msg dsAjedrecista.apellidos;
  endif;

  read AJEDRECI dsAjedrecista2;
  if not %eof;
    snd-msg dsAjedrecista2.nombre;
    snd-msg dsAjedrecista2.apellidos;
  endif;

end-proc;

// ----------------------------------------------------------------------------
// ESTRUCTURA OCCURS
// NO RECOMENDADA POR OBSOLETA!!!!!
// ----------------------------------------------------------------------------
dcl-proc Estructura_Occurs;

  dcl-ds dsDireccion qualified occurs(5) inz;
    calle char(30);
    ciudad char(20);
  end-ds;
  dcl-s ii zoned(1:0) inz;

  // Activamos la posición 1
  // Los datos informados son para el elemento 1 de los 5 posibles.
  %occur(dsDireccion) = 1;
  dsDireccion.calle = 'C/ Pepe 1';
  dsDireccion.ciudad = 'Almeria';

  // Activamos la posición 2
  %occur(dsDireccion) = 2;
  dsDireccion.calle = 'C/ Adra 2';
  dsDireccion.ciudad = 'Granada';

  for ii = 1 to 2;
    %occurs(dsDireccion) = ii;
    snd-msg dsDireccion.ciudad;
  endfor;

end-proc;
