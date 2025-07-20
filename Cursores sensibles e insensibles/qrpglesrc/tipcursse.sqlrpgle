**FREE
//*****************************************************************************
// TIPCURSSE.SQLRPGLE
//
// Uso de cursor sensible.
//*****************************************************************************
ctl-opt main(main) dftactgrp(*no) actgrp(*caller);

//*****************************************************************************
// PROCESO PRINCIPAL
//*****************************************************************************
dcl-proc main;

  dcl-s orderId int(10);
  dcl-s orderAmount packed(10:2);

  // Trabajamos con un cursor sensible, es decir, una ventana a los datos.
  // Si entre el primer fetch y el último se añaden nuevos clientes, o se cambian datos,
  // los vamos a leer.
  // Notar que en este SQL vamos a actualizar el campo ORDER_AMOUNT.
  Exec Sql
    DECLARE C1 SENSITIVE SCROLL CURSOR FOR
      SELECT ORDER_ID, ORDER_AMOUNT
      FROM ORDERS
      FOR UPDATE OF ORDER_AMOUNT;

  Exec Sql open C1;

  dow sqlStt = '00000';
    Exec Sql
      Fetch next from C1 into :orderId, :orderAmount;

    if sqlStt = '00000';
      snd-msg 'Updating order ' + %char(orderId);

      orderAmount += 10;

      Exec Sql
        UPDATE ORDERS
        SET ORDER_AMOUNT = :orderAmount
        WHERE CURRENT OF C1;
        
    endif;

  enddo;

  Exec Sql close C1;

end-proc;