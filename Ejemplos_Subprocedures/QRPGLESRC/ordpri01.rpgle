**FREE
 //************************************************
 // SUB-PROCEDURE INSIDE A PROGRAM EXAMPLE
 // TO COMPILE: 14
 // TO EXECUTE: CALL ORDPRI01
 //************************************************
  ctl-opt dftactgrp(*no) actgrp(*new);

  dcl-f ordprfm workstn;

  dcl-f ordmst disk(*ext) usage(*input) keyed;

  dcl-pr Obtener_Nombre_Producto;
    *n char(3) const;
    *n char(15);
    *n char(60);
  end-pr;

  //************************************************
  // MAIN PROCESS
  //************************************************

    F1NUMP = *blanks;
    F1NOMP = *blanks;
    F1ERR = *blanks;
    exfmt FMT01;

    dow not *inkc;
      F1ERR = *blanks;
      callP Obtener_Nombre_Producto(F1NUMP:F1NOMP:F1ERR);
      exfmt FMT01;
    enddo;

    *inlr = *on;

  //************************************************
  // SUBPROCEDURE - OBTAIN THE NAME OF A PRODUCT
  //************************************************
    dcl-proc Obtener_Nombre_Producto;
      dcl-pi *n;
        numProducto char(3) const;
        nombreProducto char(15);
        msgError char(60);
      end-pi;

      chain (numProducto) ordmst;
      if %found(ordmst);
        nombreProducto = orditmnam;
      else;
        msgError = 'Error, código de producto no encontrado';
      endIf;

    end-proc;
