# Repositorio ISMAC

## Descripción
Pagina web donde se van a visualizar las tesis de los alumnos egresados del Instituto Tecnologico Universitario ISMAC.

## Instalación desde cero

### Python
- Descargar Python desde la pagina principal (https://www.python.org/).
- Verifica que la opcion `añadir Python a Path` se encuentre activa cuando se vaya a instalar python.

### Flask
1. Ingresar al powershell como administrador.
2. Ejecutar comando `Set-ExecutionPolicy Unrestricted`
3. Aceptar; ingresando: `S`, o Aceptar todo, ingresando: `O`
- Instalar la biblioteca virtual envirtual en python:

      pip install virtualenv

- Bajar el entorno virtual dentro de la carpeta del proyecto. 
- En este caso nombramos al entorno como `env` y se creara una carpeta correspondiente.

      virtualenv -p python3 env

- Acceder a scripts y activar el entorno:

      .\env\Scripts\activate

- Deberia visualizarse 'env' ante la ruta, de la siguiente manera: `(env) PS C:\Users\...`

- Instalar Flask en el proyecto:

      pip install flask
      
- Instalar acceso a bases de datos MySQL

      pip install flask-mysql

- Verificar instalaciones:

      pip list

- Ejecutar programa con el comado `python .\carpeta\archivo.py`. En este caso:

      python .\app\app.py

- Como resultado nos entrega informacion y una URL, que por lo general corresponde a `http://127.0.0.1:5000`
- Ingresa al URL y veremos la visualizacion del proyecto

- Para cerrar el servidor se debe ingresar `ctrl+c` en el terminal.

### XAMPP
1. Instalamos Xampp desde la pagina principal (https://www.apachefriends.org/download.html)
2. Activamos a Apache y MySQL Y hacemos clic en Admin del mysql
4. Vaya a crear una base de datos y nómbrela `repositorios`.
5. Importa el archivo SQL `repositorios.sql`.