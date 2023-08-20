**FREE
 //************************************************
 // ORDSRV - THE SERVICE PROGRAM
 //
 // COMPILING THE SERVICE PROGRAM:
 //    CRTRPGMOD MODULE(MyLib/ORDSRV) SRCFILE(MyLib/QRPGLESRC)
 // CREATING THE SERVICE PROGRAM:
 //     CRTSRVPGM SRVPGM(MyLib/ORDSRV) EXPORT(*ALL)
 //************************************************
  ctl-opt nomain;

  dcl-pr Obtener_Nombre_Producto;
    *n char(3) const;
    *n char(15);
    *n char(60);
  end-pr;

  dcl-pr Obtener_Nombre_Producto_Funcion char(15);
    *n char(3) const;
    *n char(60);
  end-pr;  

  //************************************************
  // PROCEDURES
  //************************************************
  dcl-proc Obtener_Nombre_Producto export;
    dcl-pi *n;
      numProducto char(3) const;
      nombreProducto char(15);
      msgError char(60);
    end-pi;

    dcl-f ordmst disk(*ext) usage(*input) keyed;
    dcl-ds dsOrdmst likerec(rordmst);

    chain (numProducto) ordmst dsOrdmst;
    if %found(ordmst);
      nombreProducto = dsOrdmst.orditmnam;
    else;
      msgError = 'Error, código de producto no encontrado';
    endIf;

  end-proc;

  dcl-proc Obtener_Nombre_Producto_Funcion export;
    dcl-pi *n char(15);
      numProducto char(3) const;
      msgError char(60);
    end-pi;

    dcl-f ordmst disk(*ext) usage(*input) keyed;
    dcl-ds dsOrdmst likerec(rordmst);

    chain (numProducto) ordmst dsOrdmst;
    if %found(ordmst);
      return dsOrdmst.orditmnam;
    else;
      msgError = 'Error, código de producto no encontrado';
      return *blanks;
    endIf;

  end-proc;  
