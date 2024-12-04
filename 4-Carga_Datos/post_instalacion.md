# Post instalación

Despues de la instalacion de SnowSQL se deben de ejecutar 
los siguientes comandos para configurar el cliente de Snowflake

1.Configurar el cliente de Snowflake
~~~bash
code %USERPROFILE%\.snowsql\config
~~~

2.Informacion de conexion
~~~bash
accountname = <account_name>
username = <user_name>
password = <password>
~~~

3.Conectarse a snowflake
~~~bash
snowsql -c example
~~~
