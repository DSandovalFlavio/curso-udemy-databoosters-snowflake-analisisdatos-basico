-- iniciar sesión en snowflake con snowsql
-- snowsql -c example

-- Seleccionar la base de datos
USE DATABASE DATABUSTER_SAMPLE;

-- Crear el esquema
/*
DateStart,Campaign,Region,Clicks,Impressions,Views,Cost
12/24/2023,CursosDeProgramacion,Oeste,26148,133468,21979,606
*/
CREATE OR REPLACE TABLE DATABUSTER_SAMPLE.PUBLIC.CAMPAIGN_DATA (
    DateStart DATE,
    Campaign STRING,
    Region STRING,
    Clicks NUMBER,
    Impressions NUMBER,
    Views NUMBER,
    Cost NUMBER
);

-- Crear internal stage para cargar los datos
CREATE OR REPLACE STAGE internal_mkt_stage 
    FILE_FORMAT = (TYPE = 'CSV');

-- Visualizar los stages disponibles
SHOW STAGES;

-- Cargar los datos
/*
This command uses a wildcard *.csv to load multiple files. 
The @ symbol specifies where to stage the files – in this case, @internal_mkt_stage;
By default, the PUT command will compress data files using GZIP compression.
*/
PUT file://C:/Users/flavi/Teaching/curso-udemy-databoosters-snowflake-analisisdatos-basico/4-Carga_de_datos/data/dataset.csv @internal_mkt_stage;

-- Listar los archivos en el stage
LIST @internal_mkt_stage;

-- Seleccionar Virtual Warehouse a utiliza
USE WAREHOUSE COMPUTE_WH;

-- Copiar los datos del stage a la tabla
COPY INTO DATABUSTER_SAMPLE.PUBLIC.CAMPAIGN_DATA
FROM @internal_mkt_stage
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1)
ON_ERROR = 'CONTINUE';
