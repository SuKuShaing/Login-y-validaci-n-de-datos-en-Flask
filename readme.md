# Como hacer un Login (Validación de datos) con PYTHON FLASK y MySQL

Siguiendo el tutorial de GABRIEL HDS
Como hacer un Login (Validación de datos) con PYTHON FLASK y MySQL #python #mysql #flask
https://youtu.be/QO4lBskfH7w?si=ZWnY-73Isft2iRqu

2da parte del tutorial
Como hacer un Login con Roles, Privilegios de Usuario (Multi-Usuario) en Python Flask y MySQL
https://youtu.be/pkotA0tvewQ?si=OCLUW84bpqurbskQ





> [!NOTE]
> Ahora si funciona
> tuve un error y arrojaba este error
> MySQLdb.OperationalError: (2026, 'TLS/SSL error: SSL is required, but the server does not support it')
> 
> ChatGPT y Cloude diciendomente que colocara esto o que instalara varias librerías, y lo hice
> ```python
> app.config['MYSQL_SSL_DISABLED'] = True  # Deshabilitar SSL
> app.config['MYSQL_CUSTOM_OPTIONS'] = {"ssl": {"ca": "/cert/DigiCertGlobalRootG2.crt.pem"}}
> ```
>
> pero no funcionaba, cuando lo único que faltaba era que simplemente terminar la verificación en el if,
> ```python
> if request.method == 'POST' and 'txtCorreo' in request.form and 'txtPassword':
> ```
> de eso a esto, solo agregar lo que faltaba al final de la línea
> ```python
> if request.method == 'POST' and 'txtCorreo' in request.form and 'txtPassword' in request.form:
> ```
> y listo.
> dios mio, 4 hrs en ese error,
> lo bueno es que ya está solucionado
> En la siguiente linea está correcto