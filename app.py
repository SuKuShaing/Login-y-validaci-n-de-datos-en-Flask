from flask import Flask, render_template, redirect, request, Response, session
from flask_mysqldb import MySQL, MySQLdb

app = Flask(__name__, template_folder='templates')

app.config['MYSQL_HOST'] = 'localHost'
app.config['MYSQL_USER'] = 'fazt'
app.config['MYSQL_PASSWORD'] = 'fazt'
app.config['MYSQL_DB'] = 'login'
app.config['MYSQL_CURSORCLASS'] = 'DicCursor'

mysql = MySQL(app)

@app.route('/')
def home():
    return render_template('index.html')


if __name__ == '__main__':
    app.secret_key = "Seba_bkns"
    app.run(debug = True, host = '0.0.0.0', port = 5000, threaded = True)
    # "threaded = True" habilita el manejo de solicitudes concurrentes mediante subprocesos.