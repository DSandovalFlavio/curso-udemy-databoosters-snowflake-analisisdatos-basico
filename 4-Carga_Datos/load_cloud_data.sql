/*
Integraciones de Almacenamiento: Permiten a Snowflake acceder a GCS sin necesidad de credenciales explícitas. Snowflake utiliza una cuenta de servicio de Cloud Storage para la autenticación.
Creación de la Integración: Se utiliza el comando CREATE STORAGE INTEGRATION para definir la integración, especificando el proveedor de almacenamiento (GCS), los buckets permitidos (STORAGE_ALLOWED_LOCATIONS) y, opcionalmente, los bloqueados (STORAGE_BLOCKED_LOCATIONS).
*/

-- Crear la integración
CREATE STORAGE INTEGRATION IF NOT EXISTS gcs_integration
    TYPE = EXTERNAL_STAGE
    STORAGE_PROVIDER = 'GCS'
    ENABLED = TRUE
    STORAGE_ALLOWED_LOCATIONS = ('gcs://databoosters-snowflake-data/');

-- Visualizar la integración
DESC STORAGE INTEGRATION gcs_integration;

-- Crear etapa externa
USE DATABASE DATABUSTER_SAMPLE;
CREATE OR REPLACE STAGE external_gcs_mkt_stage
    URL = 'gcs://databoosters-snowflake-data/'
    STORAGE_INTEGRATION = gcs_integration;

-- Visualizar los archivos en el stage
LIST @external_gcs_mkt_stage;

-- Crear tabla
CREATE OR REPLACE TABLE DATABUSTER_SAMPLE.PUBLIC.CAMPAIGN_DATA_GCS (
    DateStart DATE,
    Campaign STRING,
    Region STRING,
    Clicks NUMBER,
    Impressions NUMBER,
    Views NUMBER,
    Cost NUMBER
);

-- Copiar los datos del stage a la tabla
COPY INTO DATABUSTER_SAMPLE.PUBLIC.CAMPAIGN_DATA_GCS
FROM @external_gcs_mkt_stage
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1)
ON_ERROR = 'CONTINUE';
