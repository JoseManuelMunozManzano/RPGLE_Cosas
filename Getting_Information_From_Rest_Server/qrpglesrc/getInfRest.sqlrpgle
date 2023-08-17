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

end-proc;
