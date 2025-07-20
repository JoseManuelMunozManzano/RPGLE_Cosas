**FREE
//*****************************************************************************
// TIPCURSIN.SQLRPGLE
//
// Uso de cursor insensible
//*****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

//*****************************************************************************
// PROCESO PRINCIPAL
//*****************************************************************************
dcl-proc main;

  dcl-s customerId int(10);
  dcl-s customerName varchar(100);
  dcl-s customerEmail varchar(100);

  // Trabajamos con un cursor insensible, es decir, un snapshot de los datos.
  // Si entre el primer fetch y el último se añaden nuevos clientes, o se cambian datos,
  // no los vamos a leer.
  Exec Sql
    DECLARE C1 INSENSITIVE CURSOR FOR
      SELECT CUSTOMER_ID, CUSTOMER_NAME, CUSTOMER_EMAIL
      FROM CUSTOMERS;

  Exec Sql open C1;

  dow sqlStt = '00000';
    Exec Sql
      Fetch next from C1 into :customerId, :customerName, :customerEmail;

    if sqlStt = '00000';
      snd-msg 'Customer ' + %char(customerId) + '-' + customerName;
    endif;

  enddo;

  Exec Sql close C1;

end-proc;