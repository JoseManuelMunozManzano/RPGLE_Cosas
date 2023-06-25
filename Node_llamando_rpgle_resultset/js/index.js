import odbc from 'odbc';

async function connection() {
  const conn = await odbc.connect(`DSN=*LOCAL;NAM=1;CMT=0;DBQ=,*USRLIBL,JOMUMA1`);
  const result = await conn.query('CALL JOMUMA1.RESULTTEST()');

  result.forEach((row) => {
    console.log(row);
  });
}

connection();
