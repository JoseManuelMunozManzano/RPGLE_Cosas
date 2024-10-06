# USO DE SND-MSG y ON-EXCP

Estos fuentes están inspirados en el siguiente video de Christian Larsen: `https://www.youtube.com/watch?v=ssZBOgiJqYs`

Podemos usar `SND-MSG` en un debug, para mandar mensajes al `Job Log`, pero también podemos usarlo para comunicar mensajes de error o de escape que pueden ser capturados por otros procedures y programas.

Lo normal es pasar variables o parámetros que contienen estos valores de error.

Vamos a ver como hacer esto mismo pasando mensajes, usando `SND-MSG` y `ON-EXCP`.

## Testing

- Creamos un fichero de mensajes, utlizando el comando
  - CRTMSGF MSGF(MSGFJM) TEXT('MI FICHERO DE MENSAJES')
- Para trabajar con el fichero de mensajes, pudiendo añadir, modificar y borrar mensajes, utilizar el comando
  - WRKMSGD MSGF(MSGFJM)
- Crear un mensaje utilizando la opción F6=Crear. He creado el siguiente mensaje
  ```
    Message ID  Severity  Message Text
     MSG0001        0     Error. División entre cero
  ```
- Ahora podemos usar ese mensaje dentro de los programas.
- Ejecutar el programa RPGLE. Se puede hacer debug
  - CALL SNDMSGEX
- Usar `DSPJOBLOG` y `F10` para ver resultados
