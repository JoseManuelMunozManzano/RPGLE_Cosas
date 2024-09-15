# USO DE %SPLIT

Estos fuentes están inspirados en el siguiente video de Christian Larsen: `https://www.youtube.com/watch?v=7E-rTr3zS3Q&t=5s`

Con %Split, podemos dividir una cadena de caracteres. Se puede indicar uno o más separadores.

Por defecto, %split no tiene en cuenta posibles cadenas vacías, es decir, con este texto

`Hola    que tal`

Si indicamos la siguiente instrucción: `pieces = %split(string:' ');`, en pieces se guardará: `Hola`, `que`, `tal`.

Esto puede ser un problema en ficheros CSV donde puede haber varias comas juntas, porque no viene información.

Para que la función %split tenga en cuenta también esas cadenas vacías, usamos el parámetro `*ALLSEP`.

Es decir, para este texto:

`Hola   que tal`

Si indicamos la siguiente instrucción: `pieces = %split(string:' ':*allSep);`, en pieces se guardará: `Hola`, ` `, ` `, `que`, `tal`.

## Testing

- Ejecutar el programa RPGLE. Se puede hacer debug
  - CALL EXSPLIT
- Usar `DSPJOBLOG` y `F10` para ver resultados
