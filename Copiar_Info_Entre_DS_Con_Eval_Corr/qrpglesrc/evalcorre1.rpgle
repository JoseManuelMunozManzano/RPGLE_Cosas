**FREE
//*****************************************************************************
// EVALCORRE1
//     Ejemplo de copia de una estructura a otra usando EVAL-CORR
//*****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

//*****************************************************************************
// PROCESO PRINCIPAL
//*****************************************************************************
dcl-proc main;

  dcl-f ajedreci usage(*input)
                 extdesc('JOMUMA1/AJEDRECI')
                 extfile(*extdesc)
                 keyed;

  // Si queremos usar un fichero declarado dentro de un procedimiento, tenemos
  // que usar una DS para tratar con las operaciones de lectura/escritura.
  dcl-ds dsAjedrecistas likerec(rAjedreci);

  // Importante: Los campos de esta estructura tienen el mismo nombre
  // que el de la tabla AJEDRECI.
  //
  // Podemos, eso si, indicar menos campos de los que tiene la tabla, como
  // en este caso, que solo hemos indicados 2 campos de una tabla que tiene 5.
  //
  // También puede haber otros campos que no existen en la tabla AJEDRECI.
  // En ese caso, los campos extra los asignamos manualmente.
  // Ejemplo: otroCampo no existe en AJEDRECI.
  dcl-ds structure dim(*auto:1000) qualified;
    id zoned(5:0) inz;
    nombre varchar(50);
    otroCampo varchar(10);
  end-ds;

  dcl-ds otherStructure likeDs(structure) dim(*auto:1000);

  dcl-s z zoned(5:0) inz;

  %elem(structure) = 0;

  setll *loval ajedreci;
  read ajedreci dsAjedrecistas;
  dow not %eof(ajedreci);
    z = %elem(structure) + 1;

    // Copiado manual
    // structure(z).id = dsAjedrecistas.id;
    // structure(z).nombre = dsAjedrecistas.nombre;
    // structure(z).otroCampo = 'OTRO';

    // Copiado usando EVAL-CORR
    eval-corr structure(z) = dsAjedrecistas;
    structure(z).otroCampo = 'Otro campo';

    read ajedreci dsAjedrecistas;
  enddo;

  // Si ahora queremos copiar todos los registros almacenados en mi estructura
  // en otra, también usamos EVAL-CORR
  // Vemos que no hace falta ningún bucle.
  eval-corr otherStructure = structure;

end-proc;
