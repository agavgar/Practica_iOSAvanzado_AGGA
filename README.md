**Práctica para el módulo iOS Avanzado de Keepcoding.**

En esta práctica desarrollo una app con lenguaje swift y con CoreData bajo el patrón de diseño MVVM (Model - View - ViewModel). Para su elaboración se consumido la API de Dragon Ball para realizar llamadas de red. Guardamos el token en Keychain para mayor seguridad y guardamos todos los datos en una base de datos de CoreData. También he trabajado con MapKit para añadir las localizaciones y el SearchBar de Apple con filtros para conseguir la aplicación.

**Resultado: APTO**

![Simulator Screenshot - iPhone 15 - 2024-02-27 at 13 47](https://github.com/agavgar/Practica_iOSAvanzado_AGGA/assets/98350985/c72a49e9-fe09-45ce-97c2-006566678d03)
![Simulator Screenshot - iPhone 15 - 2024-02-27 at 13 47-3](https://github.com/agavgar/Practica_iOSAvanzado_AGGA/assets/98350985/13cd511f-bbb6-4854-a53d-0d6661597bca)
![Simulator Screenshot - iPhone 15 - 2024-02-27 at 13 47-2](https://github.com/agavgar/Practica_iOSAvanzado_AGGA/assets/98350985/6c58b439-332f-4193-87b2-377d226371c1)
![Simulator Screenshot - iPhone 15 - 2024-02-27 at 13 47-4](https://github.com/agavgar/Practica_iOSAvanzado_AGGA/assets/98350985/8a044ac9-20b8-4b86-81e3-83602a93d918)
![Simulator Screenshot - iPhone 15 - 2024-02-27 at 13 47-5](https://github.com/agavgar/Practica_iOSAvanzado_AGGA/assets/98350985/2a439a35-21ae-45a8-b312-ecc959df9b65)


**Breve descripción**

Seguimos trabajando con Dragon Ball. Ya que su historia tiene muchos personajes interesantes, en esta app solo tenemos 3 pantallas pero se dedican a recibir, guardar o borrar información de una base de datos interna. Podemos filtrar los personajes por nombre y vienen ordenados direcatamente. En este caso, creamos un modelo de CoreData, les añadimos las clases por defecto, cambiando la estructura NSManagedObject de las uniones por un diccionario Set. Luego definimos una función StoreDataProvider que se dedica a realizar las funciones necesarias para la manipulación de la base de datos así cómo de añadir, cargar, guardar o borrar. Luego hemos cambiado el useCase por el ApiProvider que es la función que se encarga de realizar las llamadas a la API con DataTask y URLSession.

**Guía de instalación**

Simplemente debemos descargarnos el prouyecto en ZIP o en HTTP y clonar el repositorio. Luego ejecutar el archivo del proyecto de xCode y con pulsar al play tendremos la aplicación funcionando. Solo usuarios con MAC y xCode instalado.

**Experiencia**

Aqui seguimos con Dragon y nuevamente otro diseño distinto. Ahora estoy buscando un estilo más Material Design y probando añadir los personajes en circular. Creo que le da un toque más seria a la aplicación además de añadir más espacio visual muy importante para el ojo. El trabajar con CoreData ha sido subir un nivel, así como la realización del modelo E/R muy básico para está práctica pero útil para relacionar los modelos. El trabajar con mapkit también es una manera interesante de progresar. Un trabajo muy satisfactorio y contendo de no dejar de ser cómodo e ir probando cosas nuevas en UI.
