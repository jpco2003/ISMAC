from flask import Flask
from flask import Flask, render_template, request, redirect, session, send_from_directory,flash
from flaskext.mysql import MySQL
from datetime import datetime
import os

app = Flask(__name__)  #Inicializa aplicacion.
app.secret_key="secretkey"

mysql = MySQL()
app.config['MYSQL_DATABASE_HOST'] = "localhost"
app.config['MYSQL_DATABASE_USER'] = "root"
app.config['MYSQL_DATABASE_PASSWORD'] = ""
app.config['MYSQL_DATABASE_DB'] = "repositorios"
mysql.init_app(app)

#Rutas
@app.route('/')
def index():
    return render_template('site/index.html')

@app.route('/css/<archivocss>')
def css(archivocss):
    return send_from_directory(os.path.join('templates\site\css'),archivocss)

@app.route('/files/<pdf>')
def pdf(pdf):
    print(pdf)
    print(os.path.join('Pagina_Flask/app/templates/files/'),pdf)
    return send_from_directory(os.path.join('templates/files'),pdf)

@app.route('/images/Web/<imagen>')
def imagenes_web(imagen):
    print(imagen)
    print(os.path.join('Pagina_Flask/app/templates/images/Web/'),imagen)
    return send_from_directory(os.path.join('templates/images/Web'),imagen)

@app.route('/images/Docentes/<imagen>')
def imagenes_docentes(imagen):
    print(imagen)
    print(os.path.join('Pagina_Flask/app/templates/images/Docentes/'),imagen)
    return send_from_directory(os.path.join('templates/images/Docentes'),imagen)

@app.route('/images/Egresados/<imagen>')
def imagenes_egresados(imagen):
    print(imagen)
    print(os.path.join('Pagina_Flask/app/templates/images/Egresados/'),imagen)
    return send_from_directory(os.path.join('templates/images/Egresados'),imagen)

@app.route('/tesis')
def tesis():
    conexion = mysql.connect()
    cursor = conexion.cursor()
    cursor.execute("SELECT * FROM `tesis` WHERE `ACTIVE_T`=1")
    tesis=cursor.fetchall()
    conexion.commit()

    return render_template('site/tesis.html', tesis=tesis)

@app.route('/details', methods=['GET', 'POST'])
def details():
    _id=request.form['txtID']

    conexion = mysql.connect()
    cursor = conexion.cursor()
    cursor.execute("SELECT * FROM `tesis` WHERE `ACTIVE_T`=1 and`ID_T`= %s" ,(_id))       
    tesis=cursor.fetchall()
    conexion.commit()

    return render_template('site/details.html', tesis=tesis)

@app.route('/search', methods=['GET', 'POST'])
def search():

  query = request.args.get('word')
  results = []
  
  conexion = mysql.connect()
  cursor = conexion.cursor()
  cursor.execute("SELECT * FROM `tesis` WHERE `ACTIVE_T`=1 and `TITULO_T` LIKE %s" ,('%' + query + '%'))
  results = cursor.fetchall()         
  cursor.close()
  conexion.close()
  
  return render_template('site/search.html', query=query, results=results, mensaje="Error: '"+query+"' No Encontrado")

@app.route('/admin/register')
def register():
    return render_template('admin/register.html')

@app.route('/admin/register/save',methods=['POST'])
def admin_register_save():

    _usuario=request.form['txtNombre']
    _password=request.form['txtPassword']
    _email=request.form['txtEmail']

    conexion = mysql.connect()
    cursor = conexion.cursor()
    cursor.execute("SELECT * FROM `moderadores` WHERE CORREO_M=%s",(_email))
    admin=cursor.fetchone()

    if admin is None:
        sql="INSERT INTO `moderadores` (`ID_M`, `NOMBRE_M`, `CORREO_M`, `CONTRASENA_M`) VALUES (NULL,%s,%s,%s);"
        datos=(_usuario,_email,_password)
        conexion = mysql.connect()      #Conexion.
        cursor=conexion.cursor()        #Se genera un cursor.
        cursor.execute(sql,datos)       #Cursor ejecuta el comando sql.
        conexion.commit()               #Se lleva a cabo.
        return redirect('/admin/login')
    else:
        flash('Username is already taken.')

    return render_template('/admin/register.html', mensaje="Error: '"+_email+"' Ya Registrado")

@app.route('/admin')
def admin():

    if not 'login' in session:
        return render_template('/admin/login.html')

    return render_template('admin/index.html')

@app.route('/admin/login')
def login():
    return render_template('admin/login.html')

@app.route('/admin/login', methods=['GET', 'POST'])
def admin_login():
    if request.method == 'POST':
        _usuario=request.form['txtUsername']
        _password=request.form['txtPassword']

        conexion = mysql.connect()
        cursor = conexion.cursor()
        cursor.execute("SELECT * FROM `moderadores` WHERE NOMBRE_M=%s AND CONTRASENA_M=%s",(_usuario,_password))
        admin=cursor.fetchone()

        if admin:
            session["login"]=True
            session["usuario"]=_usuario
            return redirect("/admin")

    return render_template('/admin/login.html', admin=admin, mensaje="Error: datos no coinciden")

@app.route('/admin/cerrar')
def cerrar_session():
    session.clear()
    return render_template('/admin/login.html')

@app.route('/admin/tesis')
def adminTesis():

    if not 'login' in session:
        return render_template('/admin/login.html')

    conexion = mysql.connect()
    cursor = conexion.cursor()
    cursor.execute("SELECT * FROM `tesis`")
    tesis=cursor.fetchall()
    conexion.commit()

    return render_template('admin/tesis.html', tesis=tesis)

@app.route('/admin/tesis/save', methods=['GET','POST'])
def tesisSave():

    if not 'login' in session:
        return render_template('/admin/login.html')

    _tesis=request.form['txtTesis']
    _autor=request.form['txtAutor']
    _profesor=request.form['txtProfesor']
    _anio=request.form['txtAnio']
    _pdf=request.files['pdfTesis']
    _titulo=request.form['txtTitulo']
    _facultad=request.form['txtFacultad']
    _tema=request.form['txtTema']
    _mail=request.form['txtMail']
    _contacto=request.form['txtContacto']

    _fotoAutor=request.files['imgAutor']
    _fotoDocente=request.files['imgDocente']
    print(_facultad)

    tiempo = datetime.now()
    horaActual=tiempo.strftime('%Y%H%M%S')

    if _pdf.filename!="":
        nuevoNombre = horaActual+"_"+_pdf.filename
        filesPath = "Pagina_Flask/app/templates/files/"
        _pdf.save(filesPath+nuevoNombre)

    if _fotoAutor.filename!="":
        nombreFotoAutor = horaActual+"_"+_fotoAutor.filename
        filesPath = "Pagina_Flask/app/templates/images/Egresados/"
        _fotoAutor.save(filesPath+nombreFotoAutor)

    if _fotoDocente.filename!="":
        nombreFotoDocente = horaActual+"_"+_fotoDocente.filename
        filesPath = "Pagina_Flask/app/templates/images/Docentes/"
        _fotoDocente.save(filesPath+nombreFotoDocente)


    _username=session.get('usuario')
    print("USERNAME:"+_username)

    conexion = mysql.connect()
    cursor = conexion.cursor()
    cursor.execute("SELECT `ID_M` FROM `moderadores` WHERE `NOMBRE_M` = %s",(_username))
    result = cursor.fetchone()
    if result:
        id = result[0]
    else:
        id = None
    print("ID: ",id)
    cursor.close()
    conexion.close()


    sql="INSERT INTO `tesis` (`ID_T`, `ID_M`, `TITULO_T`, `AUTORES_T`, `PROFESOR_T`, `ANIO_T`, `ARCHIVO_T`,`TITULO_OPTADO_T`,`FACULTAD_T`,`TEMA_T`,`MAIL_T`,`CONTACTO_T`,`EGRESADO_T`,`DOCENTE_T`) VALUES (NULL, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);"
    datos=(id,_tesis,_autor,_profesor,_anio,nuevoNombre,_titulo,_facultad,_tema,_mail,_contacto,nombreFotoAutor,nombreFotoDocente)
    conexion = mysql.connect()      #Conexion.
    cursor=conexion.cursor()        #Se genera un cursor.
    cursor.execute(sql,datos)       #Cursor ejecuta el comando sql.
    conexion.commit()               #Se lleva a cabo.

    return redirect('/admin/tesis')

@app.route('/admin/tesis/delete', methods=['POST'])
def tesisDelete():

    if not 'login' in session:
        return render_template('/admin/login.html')

    _id=request.form['txtID']

    conexion = mysql.connect()
    cursor = conexion.cursor()
    cursor.execute("SELECT archivo_t FROM `tesis` WHERE ID_T=%s", _id)
    tesis=cursor.fetchall()
    conexion.commit()

    if os.path.exists("Pagina_Flask/app/templates/files/"+str(tesis[0][0])):
        os.remove("Pagina_Flask/app/templates/files/"+str(tesis[0][0]))

    conexion = mysql.connect()
    cursor = conexion.cursor()
    cursor.execute("DELETE FROM `tesis` WHERE ID_T=%s", _id)
    tesis=cursor.fetchall()
    conexion.commit()

    return redirect('/admin/tesis')

@app.route('/admin/tesis/desactive', methods=['POST'])
def tesisDesactivate():

    if not 'login' in session:
        return render_template('/admin/login.html')

    _id=request.form['txtID']

    conexion = mysql.connect()
    cursor = conexion.cursor()
    cursor.execute("SELECT archivo_t FROM `tesis` WHERE ID_T=%s", _id)
    tesis=cursor.fetchall()
    conexion.commit()

    conexion = mysql.connect()
    cursor = conexion.cursor()
    cursor.execute("UPDATE `tesis` SET ACTIVE_T=0 WHERE ID_T=%s", _id)
    tesis=cursor.fetchall()
    conexion.commit()

    return redirect('/admin/tesis')

@app.route('/admin/tesis/active', methods=['POST'])
def tesisActivate():

    if not 'login' in session:
        return render_template('/admin/login.html')

    _id=request.form['txtID']

    conexion = mysql.connect()
    cursor = conexion.cursor()
    cursor.execute("SELECT archivo_t FROM `tesis` WHERE ID_T=%s", _id)
    tesis=cursor.fetchall()
    conexion.commit()

    conexion = mysql.connect()
    cursor = conexion.cursor()
    cursor.execute("UPDATE `tesis` SET ACTIVE_T=1 WHERE ID_T=%s", _id)
    tesis=cursor.fetchall()
    conexion.commit()

    return redirect('/admin/tesis')

if __name__ == '__main__':  #Comprobar que estemos situados en el archivo principal.
    app.run(debug=True)