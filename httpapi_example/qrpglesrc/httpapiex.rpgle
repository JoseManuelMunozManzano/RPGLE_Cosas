**free
// ******************************************************************
// httpApi
// get/post/put information from/to a REST Server
// ******************************************************************
// Compile: 14
// Don't forget to add the library: LIBHTTP
// ******************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp('HTTPAPIEX')
  bnddir('HTTPAPI');

/copy httpapi_h

dcl-proc main;

  dcl-s url varchar(200) inz;
  dcl-s result varchar(1600000);
  dcl-s message varchar(10000) inz;
  dcl-s rc int(10);

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
  rc = http_req('GET':url:*omit:result:*omit:message:
    'application/json charset=utf-8');

  if rc <= 0;
    snd-msg 'Error';
  endif;

  snd-msg %char(rc) + ' ' + %char(result);

  // POST
  // The same as get but with type of request POST
  url = 'http://my-json-server.typicode.com/typicode/demo/posts';
  message = '{"name" : "Hello"}';
  rc = http_req('POST':url:*omit:result:*omit:message:
    'application/json charset=utf-8');

  if rc <= 0;
    snd-msg 'Error';
  endif;

  snd-msg %char(rc) + ' ' + %char(result);

  // PUT
  // The same as get but with type of request POST
  url = 'http://my-json-server.typicode.com/typicode/demo/posts/1';
  message = '{"name" : "Good Bye"}';
  // Adding header
  http_xproc(HTTP_POINT_ADDL_HEADER:%paddr(addHeader));

  rc = http_req('PUT':url:*omit:result:*omit:message:
    'application/json charset=utf-8');

  if rc <= 0;
    snd-msg 'Error';
  endif;
  // Removing header
  http_xproc(HTTP_POINT_ADDL_HEADER:*null);

  snd-msg %char(rc) + ' ' + %char(result);

end-proc;

// Header
dcl-proc addHeader;

  dcl-pi *n;
    header varchar(1024);
    userData pointer value;
  end-pi;

  header = 'Value: XXX' + x'0d25' +
    'Value2: XXX' + x'0d25';

end-proc;
