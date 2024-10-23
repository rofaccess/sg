# SG
Aplicación RoR desarrollada en la asignatura Sistemas de Gestión

## Ejecución
Iniciar la aplicación
````sh
$ docker compose up
````

Inicializar la base de datos (crear base de datos, ejecutar migraciones y seed)
````sh
$ docker compose exec -it dev rake db:setup
````

Acceder a http://localhost:3000

Ctrl + c para detener la aplicación en la Terminal.

Ejecución en segundo plano
````sh
$ docker compose up dev -d # Ejecución en segundo plano
$ docker compose down # Parar ejecución en segundo plano
````

Ingresar a un contenedor en ejecución
````sh
$ docker compose exec -it db bash
$ docker compose exec -it dev bash
````

Levantar un contenedor temporal (--rm), exponer un puerto e ingresar
Útil para probar cosas dentro del contenedor
````sh
$ docker compose run --rm -p 3000:3000 dev bash
````
