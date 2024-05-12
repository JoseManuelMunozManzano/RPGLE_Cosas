            /************************************************************/
            /* VARSIZELEC: LLAMA A VARSIZELEN                           */
            /************************************************************/
            PGM

              DCL VAR(&TEXTO) TYPE(*CHAR) LEN(80)
              DCL VAR(&TEXTORES) TYPE(*CHAR) LEN(80)

              /* funciona */
              CALL PGM(JOMUMA1/VARSIZELEN) PARM(('---------------------------------+
              ---------------------' (*CHAR 80)) &TEXTORES)

              /* no funciona */
              CALL PGM(JOMUMA1/VARSIZELEN) PARM('---------------------------------+
              ---------------------' &TEXTORES)

            ENDPGM
