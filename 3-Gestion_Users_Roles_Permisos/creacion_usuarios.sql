USE ROLE ACCOUNTADMIN;
CREATE ROLE analista_datos;
GRANT USAGE ON DATABASE DATABUSTER_SAMPLE TO ROLE analista_datos;
GRANT USAGE ON SCHEMA DATABUSTER_SAMPLE.PUBLIC TO ROLE analista_datos;
GRANT SELECT ON TABLE DATABUSTER_SAMPLE.PUBLIC.CAR_SALES TO ROLE analista_datos;

CREATE USER ana_maria IDENTIFIED BY 'contraseña_segura'; 
GRANT ROLE analista_datos TO USER ana_maria;

pedro_lopez
'contrasenia_segura'