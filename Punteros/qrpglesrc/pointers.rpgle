**free
// ****************************************************************************
//  pointers
//  Programa que hace uso de punteros para crear un array dinámico
// ****************************************************************************
ctl-opt main(main) actgrp(*caller);

dcl-s dinamicArray_t pointer template;

dcl-ds dsNode_t qualified template inz;
  text varchar(100);
  ptrNext like(dinamicArray_t);
end-ds;

// ****************************************************************************
// PROCESO PRINCIPAL
// ****************************************************************************
dcl-proc main;

  dcl-s $i zoned(2:0) inz;
  dcl-s array like(dinamicArray_t);

  Initialize_Array(array);

  for $i = 1 to 10;
    Add_Node('Node ' + %char($i):array);
  endfor;

  // Recuperar algunos nodos y escribir el contenido en el joblog
  snd-msg Retrieve_Node(1:array);
  snd-msg Retrieve_Node(8:array);
  snd-msg Retrieve_Node(3:array);
  snd-msg Retrieve_Node(9:array);
  
  // Eliminar el array de la memoria antes de terminar el programa
  Initialize_Array(array);
  
end-proc;

// ----------------------------------------------------------------------------
// Inicializar el array
// ----------------------------------------------------------------------------
dcl-proc Initialize_Array;

  dcl-pi *n;
    i_o_array like(dinamicArray_t);
  end-pi;

  dcl-s found ind;
  dcl-s ptrAux pointer;
  dcl-s ptrAux2 pointer;
  dcl-ds dsNodeAux likeds(dsNode_t) based(ptrAux);
  dcl-ds dsNodeAux2 likeds(dsNode_t) based(ptrAux2);

  if i_o_array = *null;
    return;  
  endif;

  found = *off;
  ptrAux = i_o_array;
  dou found;
    if dsNodeAux.ptrNext = *null;
      dealloc(n) ptrAux;
      found = *on;
      snd-msg 'Memory deallocated';
      return;
    endif;

    ptrAux2 = ptrAux;
    ptrAux = dsNodeAux.ptrNext;
    dealloc(n) ptrAux2;
    snd-msg 'Memory deallocated';
  enddo;

  return;

end-proc;

// ----------------------------------------------------------------------------
// Añadir un nuevo nodo
// ----------------------------------------------------------------------------
dcl-proc Add_Node;

  dcl-pi *n;
    in_texto varchar(100) const;
    i_o_array like(dinamicArray_t);
  end-pi;

  dcl-s found ind;
  dcl-s ptrNode pointer;
  dcl-s ptrAux pointer;
  dcl-ds dsNodeAux likeds(dsNode_t) based(ptrAux);
  dcl-ds dsNode likeds(dsNode_t) based(ptrNode);

  // Creamos el nodo en memoria dinámica
  ptrNode = %alloc(%size(dsNode));
  dsNode.text = in_texto;
  snd-msg 'Memory allocated';

  if i_o_array = *null;
    i_o_array = ptrNode;
  else;
    found = *off;
    ptrAux = i_o_array;
    dou found;
      if dsNodeAux.ptrNext = *null;
        dsNodeAux.ptrNext = ptrNode;
        found = *on;
        return;
      endif;
      ptrAux = dsNodeAux.ptrNext;
    enddo;
  endif;

  return;

end-proc;

// ----------------------------------------------------------------------------
// Recuperar el texto del nodo
// ----------------------------------------------------------------------------
dcl-proc Retrieve_Node;

  dcl-pi *n varchar(100);
    in_pos zoned(2:0) const;
    in_array like(dinamicArray_t);
  end-pi;

  dcl-s $i zoned(2:0) inz;
  dcl-s ptrAux pointer;
  dcl-ds dsNodeAux likeds(dsNode_t) based(ptrAux);
  
  ptrAux = in_array;
  $i = 1;
  dow $i <= in_pos;
    if $i = in_pos;
      return dsNodeAux.text;
    endif;
    $i += 1;
    ptrAux = dsNodeAux.ptrNext;
  enddo;

  return 'ERROR!';

end-proc;
