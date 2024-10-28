from flask import Flask, render_template, redirect, request, Response, session, flash
from flask_mysqldb import MySQL, MySQLdb


app = Flask(__name__, template_folder="templates")

app.config["MYSQL_HOST"] = "localHost"
app.config["MYSQL_USER"] = "fazt"
app.config["MYSQL_PASSWORD"] = "fazt"
app.config["MYSQL_DB"] = "login"
app.config["MYSQL_CURSORCLASS"] = "DictCursor"
# app.config['MYSQL_SSL_DISABLED'] = True  # Deshabilitar SSL
# app.config['MYSQL_CUSTOM_OPTIONS'] = {"ssl": {"ca": "/cert/DigiCertGlobalRootG2.crt.pem"}}
# 'MYSQL_CURSORCLASS' es una configuración en Flask-MySQLdb que especifica el tipo de cursor que se utilizará para las consultas a la base de datos. En este caso, 'DictCursor' se utiliza para que los resultados de las consultas se devuelvan como diccionarios en lugar de tuplas.

app.secret_key = "Sebabkns"

mysql = MySQL(app)


@app.route("/")
def home():
    return render_template("index.html")


@app.route("/admin")
def admin():
    return render_template("admin.html")


# Función de Login
@app.route("/acceso-login", methods=["GET", "POST"])
def login():
    if (
        request.method == "POST"
        and "txtCorreo" in request.form
        and "txtPassword" in request.form
    ):
        _correo = request.form["txtCorreo"]
        _password = request.form["txtPassword"]

        cur = mysql.connection.cursor()
        cur.execute(
            "SELECT * FROM usuarios WHERE correo = %s AND password = %s",
            (
                _correo,
                _password,
            ),
        )
        account = cur.fetchone()

        if account:
            session["loggeado"] = True
            session["id"] = account["id"]
            session["id_rol"] = account["id_rol"]

            if session["id_rol"] == 1:
                return render_template("admin.html")
            elif session["id_rol"] == 2:
                return render_template("usuarioComun.html")
        else:
            return render_template("index.html", mensaje="Usuario Inconrrecto")


# Función de logOut
@app.route("/logout")
def logout():
    session.clear()
    return redirect("/")


# Registro de usuario
@app.route("/registro")
def registro():
    return render_template("registro.html")


@app.route("/crear-registro", methods=["GET", "POST"])
def crear_registro():
    correo = request.form["txtCorreo"]
    password = request.form["txtPassword"]

    cur = mysql.connection.cursor()
    cur.execute(
        "INSERT INTO usuarios (correo, password, id_rol) VALUES ( %s, %s, '2' )",
        (correo, password),
    )
    mysql.connection.commit()

    flash("Usuario creado exitosamente!")
    return redirect("/")


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000, threaded=True)
    # "threaded = True" habilita el manejo de solicitudes concurrentes mediante subprocesos.
