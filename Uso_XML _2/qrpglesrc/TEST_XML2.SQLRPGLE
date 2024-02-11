**FREE
//*******************************************************************
// TEST_XML2
//
// Lectura del fichero XML situado en /home/JOMUMA/data y escribimos
// en una DS de nuestro programa
//
//*******************************************************************
// COMPILACIÓN: 14
//
// Para comprobar como funciona, hacer Debug
//*******************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

dcl-ds dsCustomerTpl qualified template;
  typeId char(1);
  number zoned(5:0);
  name varchar(50);
  creationDate char(10);
  address varchar(50);
  country varchar(30);
  phone1 varchar(9);
  phone2 varchar(9);
end-ds;

//*******************************************************************
// PROCEDURE PRINCIPAL
//*******************************************************************
dcl-proc main;

  dcl-ds dsCustomer likeDs(dsCustomerTpl) dim(*auto:1000) inz;
  dcl-s xmlFile sqltype(clob_file);
  dcl-s path varchar(100) inz('/home/JOMUMA/data/myXml2.xml');
  dcl-s maxRows zoned(4:0) inz(1000);
  dcl-s rows zoned(4:0) inz;

  // Insertar data del archivo XML del IFS en una tabla
  clear xmlFile;
  // Para saber qué significa esto de NL, FO y SQFRD ver:
  // https://www.rpgpgm.com/2018/08/copying-any-data-to-and-from-file-in-ifs.html
  xmlFile_Name = %trimr(path);
  xmlFile_NL = %len(%trimr(xmlFile_Name));
  xmlFile_FO = SQFRD;

  Exec Sql
    INSERT INTO JOMUMA1.TESTXML VALUES(:xmlFile);

  // Leer contenido de la tabla
  %elem(dsCustomer) = 0;

  // Para trabajar con namespaces usamos *:
  // Para recuperar el valor de un atributo se usa la ruta (./ en este caso) y @
  // Si tenemos más de un tag con el mismo nombre, para recuperarlos se identifican 
  //    como un array [1], [2], ...
  Exec Sql Declare C1 Cursor For
    SELECT A.*
    FROM JOMUMA1.TESTXML B,
      XMLTABLE('$xmldocument/sample/*:Customers/*:Customer'
        PASSING B.FIELD1 AS "xmldocument"
        COLUMNS
          TYPEID char(1) PATH './@type',
          NUMBER NUMERIC(5) PATH '*:CustomerNumber',
          NAME VARCHAR(50) PATH '*:CustomerName',
          CREATIONDATE char(10) PATH '*:CreationDate',
          ADDRESS VARCHAR(50) PATH '*:Address',
          COUNTRY VARCHAR(30) PATH '*:Country',
          PHONE1 VARCHAR(9) PATH '*:Phone[1]',
          PHONE2 VARCHAR(9) PATH '*:Phone[2]'
      ) AS A;
  
  Exec Sql OPEN C1;

  Exec Sql FETCH C1 FOR :maxRows ROWS INTO :dsCustomer;

  Exec Sql GET DIAGNOSTICS :rows = ROW_COUNT;

  Exec Sql CLOSE C1;

end-proc;
