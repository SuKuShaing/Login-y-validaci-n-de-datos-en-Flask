# Como hacer un Login (Validación de datos) con PYTHON FLASK y MySQL

Siguiendo el tutorial de GABRIEL HDS
https://youtu.be/QO4lBskfH7w?si=ZWnY-73Isft2iRqu

2da parte del tutorial
https://youtu.be/pkotA0tvewQ?si=OCLUW84bpqurbskQ





> [!NOTE]
> Ahora si funciona
> tuve un error en esto
> ```python
> if request.method == 'POST' and 'txtCorreo' in request.form and 'txtPassword':
> ```
> y arrojaba este error
> MySQLdb.OperationalError: (2026, 'TLS/SSL error: SSL is required, but the server does not support it')
> 
> ChatGPT diciendomente que colocara
> ```python
> app.config['MYSQL_SSL_DISABLED'] = True  # Deshabilitar SSL
> app.config['MYSQL_CUSTOM_OPTIONS'] = {"ssl": {"ca": "/cert/DigiCertGlobalRootG2.crt.pem"}}
> ```
> cuando lo único que faltaba era que simplemente terminar la verificación en el if,
> dios mio, 4 hrs en ese error,
> lo bueno es que ya está solucionado
> En la siguiente linea está correcto
> ```python
> if request.method == 'POST' and 'txtCorreo' in request.form and 'txtPassword' in request.form:
> ```