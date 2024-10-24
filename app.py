from flask import Flask, render_template, redirect, request, Response, session
from flask_mysqldb import MySQL, MySQLdb
# este tutorial falla en esto
# MySQLdb.OperationalError: (2026, 'TLS/SSL error: SSL is required, but the server does not support it')
# y no he podido superarlo

app = Flask(__name__, template_folder='templates')

app.config['MYSQL_HOST'] = 'localHost'
app.config['MYSQL_USER'] = 'fazt'
app.config['MYSQL_PASSWORD'] = 'fazt'
app.config['MYSQL_DB'] = 'login'
app.config['MYSQL_CURSORCLASS'] = 'DictCursor'
# app.config['MYSQL_SSL_DISABLED'] = True  # Deshabilitar SSL
# app.config['MYSQL_CUSTOM_OPTIONS'] = {"ssl": {"ca": "/cert/DigiCertGlobalRootG2.crt.pem"}}
# 'MYSQL_CURSORCLASS' es una configuración en Flask-MySQLdb que especifica el tipo de cursor que se utilizará para las consultas a la base de datos. En este caso, 'DictCursor' se utiliza para que los resultados de las consultas se devuelvan como diccionarios en lugar de tuplas.

app.secret_key = 'Sebabkns'

mysql = MySQL(app)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/admin')
def admin():
    return render_template('admin.html')


# Función de Login
@app.route('/acceso-login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST' and 'txtCorreo' in request.form and 'txtPassword':
        _correo = request.form['txtCorreo']
        _password = request.form['txtPassword']

        cur = mysql.connection.cursor()
        cur.execute('SELECT * FROM usuario WHERE correo = %s AND password = %s', (_correo, _password,))
        account = cur.fetchone()
        
        if account:
            session['loggeado'] = True
            session['id'] = account['id']

            return render_template("admin.html")
        else:
            return render_template('index.html', mensaje="Usuario Inconrrecto")

    return render_template('admin.html')


if __name__ == '__main__':
    app.run(debug = True, host = '0.0.0.0', port = 5000, threaded = True)
    # "threaded = True" habilita el manejo de solicitudes concurrentes mediante subprocesos.