# AppWeb 

## Descripción
Aplicacion web para servir de repositorio de tesis.

## Estado el proyecto
    Version 1.0 - Pausado

## Instalación desde cero

### Python
- Descargar Python `version 3.11` desde la [pagina oficial](https://www.python.org/).
- Verifica que la opcion `añadir Python 3.11 a Path` se encuentre activa.

### Flask

- Instalar la biblioteca virtual envirtual en python:

      pip install virtualenv

- Bajar el entorno virtual dentro de la carpeta del proyecto. 
- En este caso nombramos al entorno como `env` y se creara una carpeta correspondiente.

      virtualenv -p python3 env

- Acceder a scripts y activar el entorno:

      .\env\Scripts\activate

- En caso de error "la ejecución de scripts está deshabilitada en este sistema".
1. Ingresar al powershell como administrador.
2. Ejecutar comando `Set-ExecutionPolicy Unrestricted`
3. Aceptar; ingresando: `S`, o Aceptar todo, ingresando: `O`

- Deberia visualizarse 'env' ante la ruta, de la siguiente manera: `(env) PS C:\Users\...`
- Instalar Flask en el proyecto:

      pip install flask
      
- Instalar acceso a bases de datos MySQL

      pip install flask-mysql

- Verificar instalaciones:

      pip list

- Crear primer `Hola Mundo`, con el siguiente codigo:
 
![HolaMundo](https://user-images.githubusercontent.com/115717996/206082127-c1bb35ca-62c9-4fb4-ad7d-365849d23a55.png)


- Ejecutar programa con el comado `python .\carpeta\archivo.py`. En este caso:

      python .\app\app.py

- Como resultado nos entrega informacion y una URL, que por lo general corresponde a `http://127.0.0.1:5000`
- Ingresa al URL desde cualquier navegador y se podra visualizar la pagina:

![Pagina](https://user-images.githubusercontent.com/115717996/206081829-c855a30b-9d6c-4090-8602-5a5ab50ddc62.png)

- Para cerrar el servidor se debe ingresar `ctrl+c` en el terminal.

### AppWeb

- Ahora puedes clonar la carpeta `Pagina_Flask/app`

### Wamp
 - Todas las versiones de Wamp para Windows están disponibles en [wampserver](https://www.wampserver.com/en/)
 - Descargue el Wamp según la arquitectura de su sistema y obtenga la `versión 3.2.6`
 
### My SQL
- En el proceso de instalación, la instalación de `MySQL 5.7` aparecerá en la sección `select components`.
- Por defecto debería aparecer seleccionado, en caso contrario selecciónelo.

### Cambiar el mecanismo de almacenamiento de MYISAM a INNODB
1. Inicia Wampserver (una vez iniciado su icono aparecerá en iconos ocultos).
2. 2. Vaya a `MySQL` y seleccione `my.ini`.
3. 3. Edita default-storage. Debe quedar de la siguiente manera:

		;default-storage-engine=MYISAM.
		default-storage-engine=InnoDB.
		
4. Reinicie Wampserver


### PHP My Admin
1. Inicie Wampserver (una vez iniciado su icono aparecerá en iconos ocultos).
2. Seleccione `phpMyAdmin`.
3. Acceda usando la siguiente cuenta por defecto.

		Nombre de usuario: root
		Contraseña: 
		
4. Vaya a crear una base de datos y nómbrela `repositorios`.
5. Importa el archivo SQL `AppBD.sql`.

### Licensia

        MIT License
