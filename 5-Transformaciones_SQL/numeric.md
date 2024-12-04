## Ejemplos de funciones de transformación de datos - Numeric en Snowflake:

**1. Redondear las ventas semanales al entero más cercano:**

```sql
SELECT 
    ROUND("Weekly_Sales") AS ventas_redondeadas
FROM 
    Sales;
```

Este ejemplo usa `ROUND` para redondear los valores de la columna `"Weekly_Sales"` al entero más cercano.

**2. Calcular el total de ventas semanales por tienda:**

```sql
SELECT 
    Store, 
    SUM("Weekly_Sales") AS total_ventas
FROM 
    Sales
GROUP BY 
    Store;
```

Este ejemplo usa `SUM` para calcular la suma de las ventas semanales (`"Weekly_Sales"`) para cada tienda (`Store`) agrupando los resultados.


**3. Calcular el promedio de temperatura por ciudad:**

```sql
SELECT 
    sd.city, 
    AVG(s.Temperature) AS promedio_temperatura
FROM 
    Sales s
JOIN 
    "Store Desc" sd ON s.Store = sd.store
GROUP BY 
    sd.city;
```

Este ejemplo calcula el promedio de la temperatura (`Temperature`) para cada ciudad (`city`) uniendo las tablas `Sales` y `"Store Desc"` y agrupando los resultados.


**4. Obtener el valor máximo de CPI por tipo de tienda:**

```sql
SELECT 
    st.Type, 
    MAX(s.CPI) AS maximo_cpi
FROM 
    Sales s
JOIN 
    Stores st ON s.Store = st.Store
GROUP BY 
    st.Type;
```

Este ejemplo usa `MAX` para obtener el valor máximo de CPI (`CPI`) para cada tipo de tienda (`Type`) uniendo las tablas `Sales` y `Stores` y agrupando los resultados.


**5. Calcular el descuento del 10% en las ventas semanales:**

```sql
SELECT 
    "Weekly_Sales", 
    "Weekly_Sales" * 0.10 AS descuento, 
    "Weekly_Sales" - ("Weekly_Sales" * 0.10) AS precio_con_descuento
FROM 
    Sales;
```

Este ejemplo calcula un descuento del 10% en las ventas semanales (`"Weekly_Sales"`) y muestra el precio con descuento.


**6. Calcular el precio del combustible en euros (asumiendo una tasa de cambio de 0.85):**

```sql
SELECT 
    Fuel_Price, 
    Fuel_Price * 0.85 AS precio_euros
FROM 
    Sales;
```

Este ejemplo multiplica el precio del combustible (`Fuel_Price`) por una tasa de cambio para obtener el precio en euros.


**7.  Determinar si las ventas semanales son mayores al promedio:**

```sql
SELECT 
    "Weekly_Sales",
    CASE 
        WHEN "Weekly_Sales" > (SELECT AVG("Weekly_Sales") FROM Sales) THEN 'Si'
        ELSE 'No'
    END AS mayor_al_promedio
FROM 
    Sales;
```

Este ejemplo usa `CASE` para determinar si las ventas semanales (`"Weekly_Sales"`) son mayores al promedio de todas las ventas semanales.


Estos son solo algunos ejemplos de cómo puedes usar las funciones de transformación numéricas en Snowflake. Puedes combinar estas funciones con otras funciones de SQL para realizar análisis y transformaciones de datos más complejas.
