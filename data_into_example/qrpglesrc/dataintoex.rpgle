**free
// ******************************************************************
// dataintoex
// get from a REST Server and save to a ds using data-into
// ******************************************************************
// Compile: 14
// Don't forget to add the libraries: LIBHTTP
//                                    YAJL
// ******************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*new)
  bnddir('HTTPAPI':'YAJL');

/copy httpapi_h
/copy yajl_h

dcl-proc main;

  dcl-s url varchar(200) inz;
  dcl-s result varchar(1600000);
  dcl-s message varchar(10000) inz;
  dcl-s rc int(10);

  dcl-s msg varchar(100);
  dcl-s errnum int(10);
  dcl-s status int(10);
  
  dcl-ds dsResult qualified inz;
    id zoned(5:0);
    title varchar(100);
  end-ds;

  // LOG of the communications
  http_debug(*on:'/home/JOMUMA/http_log.txt');

  // GET
  // Parameters:
  //    Type of request
  //    The url
  //    One of this two
  //      Result stored in an IFS file -> '/home/jmm/result.json'
  //      Result stored in a file
  //    One of this two
  //      Message to be sent into a file in the IFS
  //      Message to be sent into a field
  //    Content-Type
  url = 'http://my-json-server.typicode.com/typicode/demo/posts/1';
  
  monitor;
    rc = http_req('GET':url:*omit:result:*omit:message:
      'application/json charset=utf-8');
  on-error;
    msg = http_error( errnum : status );
  endmon;

  if rc <= 0;
    snd-msg 'Error';
    return;
  endif;

  // Moving from JSON to DS
  data-into dsResult %DATA(result) %parser('YAJLINTO');

  snd-msg %char(dsResult.id);
  snd-msg %char(dsResult.title);

end-proc;
