## Automatización de Snowpipe con Google Cloud Storage

Este tutorial te guiará a través de los pasos para configurar la carga automatizada de datos desde Google Cloud Storage (GCS) a Snowflake utilizando Snowpipe.

**Requisitos previos:**

* Una cuenta de Snowflake activa.
* Un bucket de Google Cloud Storage con los datos que deseas cargar.
* Acceso a Google Cloud Platform Console con permisos de editor de proyectos.
* Conocimientos básicos de SQL y de la interfaz de línea de comandos de Google Cloud.


**Pasos:**

**1. Configurar el acceso seguro a Cloud Storage:**

   * **Crear una integración de almacenamiento en Snowflake:**

     ```sql
     CREATE STORAGE INTEGRATION gcs_int
       TYPE = EXTERNAL_STAGE
       STORAGE_PROVIDER = 'GCS'
       ENABLED = TRUE
       STORAGE_ALLOWED_LOCATIONS = ('gcs://<your-bucket-name>/<optional-path>/', 'gcs://<another-bucket-name>/<optional-path>/')
       [ STORAGE_BLOCKED_LOCATIONS = ('gcs://<bucket-name>/<path-to-block>/', 'gcs://<another-bucket-name>/<path-to-block>/') ];
     ```
     Reemplaza `<your-bucket-name>`, `<another-bucket-name>`, `<optional-path>`, y `<path-to-block>` con tus valores.

     Ejemplo:

     ```sql
     CREATE STORAGE INTEGRATION IF NOT EXISTS gcs_integration
      TYPE = EXTERNAL_STAGE
      STORAGE_PROVIDER = 'GCS'
      ENABLED = TRUE
      STORAGE_ALLOWED_LOCATIONS = ('gcs://databoosters-snowflake-data/');
     ```

   * **Recuperar la cuenta de servicio de Cloud Storage:**

     ```sql
     DESC STORAGE INTEGRATION gcs_int;
     ```
     Anota el valor de `STORAGE_GCP_SERVICE_ACCOUNT`.

   * **Otorgar permisos a la cuenta de servicio:**
     * En Google Cloud Console, ve a IAM y administrador » Roles y crea un rol personalizado con los permisos `storage.buckets.get`, `storage.objects.get` y `storage.objects.list`.
     * Ve a Cloud Storage » Buckets, selecciona tu bucket y otorga el rol personalizado a la cuenta de servicio de Snowflake que anotaste en el paso anterior.

**2. Configurar la automatización con GCS Pub/Sub:**

   * **Crear un tema de Pub/Sub:**

     ```bash
     gsutil notification create -t <topic-name> -f json -e OBJECT_FINALIZE gs://<your-bucket-name>
     ```
      Anota el ID del tema.
    
      Ejemplo:
     ```bash
     gsutil notification create -t pipe_mkt_gcs_snow -f json -e OBJECT_FINALIZE gs://databoosters-snowflake-data
     ```
     ID del tema: `pipe_mkt_gcs_snow`

   * **Crear una suscripción de Pub/Sub:**
     * En Google Cloud Console, ve a Big Data » Pub/Sub » Suscripciones y crea una suscripción con entrega pull al tema que creaste.
     * Anota el ID de la suscripción.
      ID de la suscripción: `subs_pipe_gcs_snow`

   * **Crear una integración de notificaciones en Snowflake:**

     ```sql
     CREATE NOTIFICATION INTEGRATION notification_gcs_snow_mkt
       TYPE = QUEUE
       NOTIFICATION_PROVIDER = GCP_PUBSUB
       ENABLED = true
       GCP_PUBSUB_SUBSCRIPTION_NAME = 'projects/curso-databooster-snowflake/subscriptions/subs_pipe_gcs_snow';
     ```

   * **Otorgar acceso a Snowflake a la suscripción de Pub/Sub:**
     * Ejecuta `DESC NOTIFICATION INTEGRATION my_notification_int;` y anota el valor de `GCP_PUBSUB_SERVICE_ACCOUNT`.
     * En Google Cloud Console, ve a Big Data » Pub/Sub » Suscripciones, selecciona tu suscripción y otorga el rol "Suscriptor de Pub/Sub" a la cuenta de servicio que anotaste.
     * En la página Panel de control de Google Cloud Console, agrega la misma cuenta de servicio con el rol "Visor de supervisión".

**3. Crear una etapa:**

   ```sql
   CREATE STAGE pipe_mkt_gcs_snow
     URL='gcs://databoosters-snowflake-data'
     STORAGE_INTEGRATION = gcs_integration;
   ```

**3.5 Crear una tabla:**

  ```sql
  CREATE OR REPLACE TABLE DATABUSTER_SAMPLE.PUBLIC.performance_mkt_snow (
      Order_ID VARCHAR(255),
      Order_Date DATE,
      Ship_Date INT,
      Ship_Mode VARCHAR(255),
      Country_Region VARCHAR(255),
      City VARCHAR(255),
      State_Province VARCHAR(255),
      Postal_Code VARCHAR(255),
      Customer_Name VARCHAR(255),
      Product_Name VARCHAR(255),
      Quantity INT,
      Discount FLOAT);
  ```

**4. Crear una canalización (pipe):**

   ```sql
   CREATE OR REPLACE PIPE snowpipe_mkt_gcs_snow
     AUTO_INGEST = true
     INTEGRATION = notification_gcs_snow_mkt
     AS
       COPY INTO DATABUSTER_SAMPLE.PUBLIC.performance_mkt_snow
        FROM @pipe_mkt_gcs_snow
        FILE_FORMAT = (TYPE = 'CSV' SKIP_HEADER = 1)
        ON_ERROR = 'CONTINUE';
   ```

**5. Cargar archivos históricos (opcional):**

   ```sql
   ALTER PIPE mypipe REFRESH;
   ```

**6. Eliminar los archivos preparados (opcional):**

   Utiliza el comando `REMOVE` en Snowflake o configura las funciones de administración del ciclo de vida en Google Cloud Storage para eliminar los archivos que ya se han cargado.


**Consideraciones adicionales:**

* Revisa la sección "Gestión de tuberías de nieve" en la documentación de Snowflake para obtener información sobre cómo administrar, modificar y solucionar problemas de tus pipes.
* Puedes usar la función `SYSTEM$PIPE_STATUS` para monitorear el estado de tus pipes.


**¡Eso es todo!** Ahora Snowpipe cargará automáticamente los nuevos datos desde tu bucket de GCS a tu tabla de Snowflake. 

**Recuerda:** 

* Reemplaza los valores entre `< >` con tus propios valores.
* Adapta este tutorial a tus necesidades específicas.
* Este tutorial asume un conocimiento básico de Snowflake, Google Cloud Storage y Pub/Sub.


---

graph LR
    A[Bucket de Google Cloud Storage] --> B(Evento de creación de archivo)
    B --> C[Tema de Pub/Sub]
    C --> D[Suscripción de Pub/Sub]
    D --> E[Integración de notificaciones en Snowflake]
    E --> F[Snowpipe]
    F --> G[Stage en Snowflake]
    F --> H[Tabla en Snowflake]

    style A fill:#f9f,stroke:#333,stroke-width:2px
    style B fill:#ccf,stroke:#333,stroke-width:2px
    style C fill:#ccf,stroke:#333,stroke-width:2px
    style D fill:#ccf,stroke:#333,stroke-width:2px
    style E fill:#aaf,stroke:#333,stroke-width:2px
    style F fill:#aaf,stroke:#333,stroke-width:2px
    style G fill:#aaf,stroke:#333,stroke-width:2px
    style H fill:#aaf,stroke:#333,stroke-width:2px