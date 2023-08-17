**free
// ******************************************************************
// getInfRest
// get information from REST Server
// ******************************************************************
// Compile: 14
// ******************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

dcl-proc main;

  dcl-s url varchar(200) inz('https://my-json-server.typicode.com/typicode/demo/posts/1');
  dcl-s response varchar(10000);
  dcl-ds table qualified inz;
    responseMsg varchar(10000);
    responseHttpHeader varchar(10000);
  end-ds;

  Exec Sql
    SET OPTION COMMIT = *ALL, 
               CLOSQLCSR = *ENDACTGRP,
               ALWCPYDTA = *YES;

  // GET
  // The second parameter is the header
  Exec Sql
    SET :response = SYSTOOLS.HTTPGETCLOB(:url, null);
  
  snd-msg response;

  // GET VERBOSE
  // The first field stores the response and the second one stores http response
  Exec Sql
    VALUES (SELECT * FROM TABLE (SYSTOOLS.HTTPGETCLOBVERBOSE(:url, null))) into :table;

  snd-msg table.responseMsg;

  // GET
  // Using qsys2.http_get
  // It doesn't use Java as the others, so it's faster.
  // If the url use HTTPS you have to have sufficient privileges to use the certificate store.
  // If not, you will receive an error.
  Exec Sql
    VALUES QSYS2.HTTP_GET(:url, null) into :response;
  
  snd-msg response;

end-proc;
