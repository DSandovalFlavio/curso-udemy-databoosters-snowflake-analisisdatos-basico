## Construyendo un Modelo Dimensional de Estrella para Análisis de Ventas

Para esta práctica, vamos a construir un modelo dimensional de estrella que nos permita analizar las ventas de una tienda en línea.  Utilizaremos los datos proporcionados en el archivo CSV y seguiremos los pasos para construir un modelo dimensional efectivo.

**Contexto del Proyecto:**

El objetivo de este proyecto es crear un modelo de datos que nos permita analizar las ventas de la tienda en línea de forma eficiente.  Queremos poder responder preguntas como:

* ¿Cuáles son los productos más vendidos?
* ¿Cuáles son las categorías de productos más populares?
* ¿Cómo varían las ventas a lo largo del tiempo?
* ¿Cuáles son las ciudades con mayor volumen de ventas?

**Estructura del Modelo:**

Para lograr este objetivo, construiremos un modelo dimensional de estrella con la siguiente estructura:

* **Tabla de Hechos:** `fact_sales`
    * Métricas: `quantity_ordered`, `sales`
    * Claves foráneas: `product_id`, `city_id`, `fecha`
* **Tablas de Dimensiones:**
    * `dim_product`: `product_id`, `product`, `category`
    * `dim_city`: `city_id`, `city`
    * `dim_calendar`: `fecha`, `dia`, `mes`, `anio`, `dia_de_la_semana`, `semana_del_anio`, `tipo_dia`

**Mejora del Rendimiento:**

Para mejorar el rendimiento del modelo, prestaremos especial atención a la granularidad de los datos.  La granularidad inicial, basada en el archivo CSV, es a nivel de cada pedido individual.  Sin embargo, para el análisis, podemos agregar los datos a un nivel superior, como por ejemplo, a nivel de día, ciudad y producto.  Esto reducirá el número de filas en la tabla de hechos, lo que a su vez mejorará el rendimiento de las consultas.

**Pasos para la Construcción del Modelo:**

1. **Identificar el proceso de negocio:**  En este caso, el proceso de negocio es la venta de productos en línea.
2. **Seleccionar las métricas:**  Las métricas clave que queremos medir son la cantidad de productos vendidos (`quantity_ordered`) y las ventas totales (`sales`).
3. **Identificar las dimensiones:**  Las dimensiones que proporcionan contexto a las métricas son el producto (`product`, `category`), la ciudad (`city`) y el tiempo (`fecha`).
4. **Crear la tabla de hechos:**  Diseñaremos la tabla de hechos `fact_sales` con las métricas `quantity_ordered` y `sales`, y las claves foráneas `product_id`, `city_id` y `fecha` que la relacionan con las tablas de dimensiones.
5. **Crear las tablas de dimensiones:**  Diseñaremos las tablas de dimensiones `dim_product`, `dim_city` y `dim_calendar` con los atributos descriptivos y las jerarquías relevantes para cada dimensión.

**Conclusión:**

Con este modelo dimensional de estrella, podremos analizar las ventas de la tienda en línea de forma eficiente y responder a las preguntas de negocio clave.  La mejora en la granularidad de los datos nos permitirá realizar consultas más rápidas y obtener información valiosa para la toma de decisiones.