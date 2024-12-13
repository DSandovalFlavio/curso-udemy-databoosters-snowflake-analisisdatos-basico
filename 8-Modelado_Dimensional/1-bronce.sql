-- seleccionar la base de datos
USE DATABASE DATABUSTER_SAMPLE;

-- create schema
/*
Product,Quantity Ordered,Price Each,Order Date,Purchase Address,Category
iPhone,1,700,2019-01-22,"944 Walnut St, Boston, MA 02215",Teléfonos
*/
CREATE OR REPLACE TABLE DATABUSTER_SAMPLE.PUBLIC.SALES_DATA (
    Product STRING,
    QuantityOrdered NUMBER,
    PriceEach NUMBER,
    OrderDate DATE,
    PurchaseAddress STRING,
    Category STRING
);

-- create internal stage to load the data
CREATE OR REPLACE STAGE internal_sales_stage 
    FILE_FORMAT = (TYPE = 'CSV');

-- show available stages
SHOW STAGES;

-- load the data
PUT file://C:/Users/flavi/Teaching/curso-udemy-databoosters-snowflake-analisisdatos-basico/8-Modelado_Dimensional/data/*.csv @internal_sales_stage;

-- list the files in the stage
LIST @internal_sales_stage;

-- select the Virtual Warehouse to use
USE WAREHOUSE COMPUTE_WH;

-- copy the data from the stage to the table
COPY INTO DATABUSTER_SAMPLE.PUBLIC.SALES_DATA
FROM @internal_sales_stage
FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1)
ON_ERROR = 'CONTINUE';