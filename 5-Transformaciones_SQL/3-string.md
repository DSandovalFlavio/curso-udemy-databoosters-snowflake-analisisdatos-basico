## Ejemplos de funciones de transformación de datos - String en Snowflake:

**1. Extraer el nombre de la ciudad de la dirección:**

```sql
SELECT 
    SUBSTRING(address, 1, POSITION(' ' IN address) - 1) AS nombre_ciudad
FROM 
    "Store Desc";
```
Este ejemplo usa `SUBSTRING` y `POSITION` para extraer la primera palabra de la columna `address`, que corresponde al nombre de la ciudad.

**2. Dividir la fecha en componentes (día, mes, año):**

```sql
SELECT 
    SPLIT_PART(Date, '-', 1) AS dia,
    SPLIT_PART(Date, '-', 2) AS mes,
    SPLIT_PART(Date, '-', 3) AS anio
FROM 
    Sales;
```
Aquí, `SPLIT_PART` divide la cadena de fecha en tres partes usando el guión como delimitador, extrayendo así el día, mes y año.

**3. Reemplazar espacios en blanco por guiones bajos en la columna "city":**

```sql
SELECT 
    REPLACE(city, ' ', '_') AS ciudad_sin_espacios
FROM 
    "Store Desc";
```
Este ejemplo usa `REPLACE` para reemplazar todos los espacios en blanco en la columna `city` por guiones bajos.

**4. Concatenar la ciudad y el país:**

```sql
SELECT 
    city || ', ' || country AS ciudad_pais
FROM 
    "Store Desc";
```
Este ejemplo usa el operador de concatenación (`||`) para combinar la ciudad y el país en una sola cadena.

**5. Extraer información de la dirección usando expresiones regulares:**

```sql
SELECT 
    REGEXP_SUBSTR(address, '\\d+') AS numero_direccion,
    REGEXP_SUBSTR(address, '\\w+$') AS tipo_via
FROM 
    "Store Desc";
```
Este ejemplo usa `REGEXP_SUBSTR` para extraer el número de la dirección y el tipo de vía usando expresiones regulares.

**6. Convertir el tipo de tienda a minúsculas:**

```sql
SELECT 
    LOWER(Type) AS tipo_minusculas
FROM 
    Stores;
```
Este ejemplo usa `LOWER` para convertir el tipo de tienda a minúsculas.

**7. Eliminar espacios en blanco al inicio y al final de la dirección:**

```sql
SELECT 
    TRIM(address) AS direccion_sin_espacios
FROM 
    "Store Desc";
```
Este ejemplo usa `TRIM` para eliminar cualquier espacio en blanco al inicio o al final de la dirección.

Estos ejemplos muestran cómo puedes usar las funciones de transformación de cadenas en Snowflake para manipular datos de texto de diferentes maneras. Puedes combinar estas funciones y usarlas con otras funciones de SQL para realizar análisis y transformaciones de datos más complejas.