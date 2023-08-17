**free
// ******************************************************************
// sndInfRest
// send information to REST Server
// ******************************************************************
// Compile: 14
// ******************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

dcl-proc main;

  dcl-s url varchar(200) inz('http://my-json-server.typicode.com/typicode/demo/posts');
  dcl-s message varchar(10000) inz('{"title" = "José Manuel"}');
  dcl-s response varchar(10000);
  dcl-ds table qualified inz;
    responseMsg varchar(10000);
    responseHttpHeader varchar(10000);
  end-ds;  

  Exec Sql
    SET OPTION COMMIT = *ALL, 
               CLOSQLCSR = *ENDACTGRP,
               ALWCPYDTA = *YES;

  // In response will be the id assigned to the message

  // POST
  Exec Sql
    VALUES QSYS2.HTTP_POST(:url, :message, null)
      into :response;
  
  snd-msg response;

  // POST_VERBOSE
  Exec Sql
    SELECT *
      into :table
    FROM TABLE(QSYS2.HTTP_POST_VERBOSE(:url, :message, null));
  
  snd-msg table.responseMsg;

end-proc;
