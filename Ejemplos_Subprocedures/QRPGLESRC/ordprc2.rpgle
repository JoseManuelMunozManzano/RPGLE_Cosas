**FREE
 //************************************************
 // ORDPRC2 - CALLED PROGRAM
 //           IT WORKS WITH ORDPRC2.RPGLE 
 // TO COMPILE: 14
 // TO EXECUTE: CALL ORDPRC1
 //************************************************
  ctl-opt dftactgrp(*no) actgrp(*caller);

  dcl-f ordmst disk(*ext) usage(*input) keyed;

  dcl-pr ORDPRC2;
    *n char(3) const;
    *n char(15);
    *n char(60);
  end-pr;

  dcl-pi ORDPRC2;
    numProducto char(3) const;
    nombreProducto char(15);
    msgError char(60);
  end-pi;

  //************************************************
  // MAIN PROCESS
  //************************************************

    chain (numProducto) ordmst;
    if %found(ordmst);
      nombreProducto = orditmnam;
    else;
      msgError = 'Error, código de producto no encontrado';
    endIf;

    *inlr = *on;
