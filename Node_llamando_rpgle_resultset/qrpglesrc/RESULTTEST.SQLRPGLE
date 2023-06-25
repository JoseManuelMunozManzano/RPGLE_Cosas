**FREE
// ****************************************************************************
// RESULTTEST - Devuelve un resultset
// ****************************************************************************
Dcl-Pi RESULTTEST;
End-Pi;

Dcl-S rowCount Int(10);
Dcl-Ds resultSet Dim(5) Qualified;
  Nombre varchar(20);
  Dinero packed(11:2); //SQL decimal
  Hobby varchar(50);
End-Ds;

resultSet(1).Nombre = 'José Manuel';
resultSet(1).Dinero = 20.00;
resultSet(1).Hobby = 'Ajedrez';

resultSet(2).Nombre = 'Adri';
resultSet(2).Dinero = 67.75;
resultSet(2).Hobby = 'Leer Noticias';

resultSet(3).Nombre = 'Marina';
resultSet(3).Dinero = 23423423.12;
resultSet(3).Hobby = 'leer';

rowCount = 3;

Exec SQL Set Result Sets Array :resultSet For :rowCount Rows;

Return;
