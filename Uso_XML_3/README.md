# USO DE RESULTSET EN RPG

Estos fuentes están inspirados en el siguiente video de Christian Larsen: `https://www.youtube.com/watch?v=FamtiDYfIL8`

El uso de XML-INTO ya está un poco desfasado, debido a que tenemos DATA-INTO y, sobre todo, el manejo de XML usando SQL, pero cuando el XML a importar es sencillo, puede ser que XML-INTO sea más fácil de usar.

XML-INTO también funciona cuando hay namespaces.

Una limitación de XML-INTO es que, si no sabemos cuántos elementos tiene el XML, como la data se guarda en una DS estática, no vamos a saber que cantidad de elementos indicar en la dim de la DS.
