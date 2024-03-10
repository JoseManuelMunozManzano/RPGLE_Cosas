**FREE
//*******************************************************************
// TEST_XML3
//
// Uso de XML-INTO para XML fáciles
//
// Vemos 2 ejemplos, el segundo de ellos con namespaces
//
//*******************************************************************
// COMPILACIÓN: 14
//
// Para comprobar como funciona, hacer Debug
//*******************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

// Los nombres de las variables en mi ds TIENEN ser los mismos que los que aparecen en el XML
dcl-ds dsCustomers_t qualified template;
  numCustomer int(10:0) inz;
  dcl-ds Customer dim(10);
    customerNumber zoned(5:0);
    customerName varchar(50);
    creationDate char(10);
    address varchar(50);
    country varchar(30);
    phone varchar(9);
    type char(1);
  end-ds;
end-ds;

dcl-ds dsCustomersNamespace_t qualified template;
  numCustomer int(10:0) inz;
  dcl-ds Customer dim(10);
    ns_customerNumber varchar(20);
    customerNumber zoned(5:0);
    customerName varchar(50);
    creationDate char(10);
    address varchar(50);
    country varchar(30);
    phone varchar(9);
    type char(1);
  end-ds;
end-ds;

//*******************************************************************
// PROCEDURE PRINCIPAL
//*******************************************************************
dcl-proc main;

  dcl-ds dsCustomers likeds(dsCustomers_t) inz(*likeds);
  dcl-ds dsCustomersNamespace likeds(dsCustomersNamespace_t) inz(*likeds);

  clear dsCustomers;

  // doc=file             porque proviene de un file en el IFS
  // case=any             porque me dan igual mayúsculas/minúsculas
  // allowmissing=yes     porque quiero que se importe el XML aunque en dicho XML falten campos
  // allowextra=yes       porque quiero que xml-into ignore los campos extra que vengan en el XML
  //                      y no en mi DS
  // path=List/Customers  porque quiero que xml-into empiece a importar desde ese path
  // countprefix=num      xml-into añadirá un campo, con prefijo num, a mi ds, seguido del nombre 
  //                      ds: numCustomer, con el número de elementos importados
  xml-into dsCustomers %xml('/home/JOMUMA/data/myXML3.xml':
    'doc=file case=any allowmissing=yes allowextra=yes path=List/Customers countprefix=num');
  
  snd-msg %char(dsCustomers.numCustomer) + ' customers imported.' %target(*self:2);

  // XML con namespaces
  clear dsCustomersNamespace;

  // ns=remove            para eliminar del XML los namespaces
  // nsprefix_ns          para importar los nombres de los namespaces. Se importa en ns_customerNumber
  xml-into dsCustomersNamespace %xml('/home/JOMUMA/data/myXML3_namespaces.xml':
    'doc=file case=any allowmissing=yes allowextra=yes path=List/Customers countprefix=num +
     ns=remove nsprefix=ns_');
  
  snd-msg %char(dsCustomersNamespace.numCustomer) + ' customers imported.' %target(*self:2);  

end-proc;
