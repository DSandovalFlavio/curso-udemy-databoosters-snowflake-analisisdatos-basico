## Generando preguntas y queries SQL a partir de las tablas:

A continuación, te presento 5 ejemplos de preguntas que se pueden generar con las tablas "Sales", "Store Desc" y "Stores", junto con la explicación de cómo construir la query SQL correspondiente:

**Ejemplo 1:**

**Pregunta:** ¿Cuál es la ciudad con mayor promedio de ventas semanales en días festivos?

**Construcción de la Query:**

1. **¿Qué quiero?**: El promedio de ventas semanales ("Weekly_Sales") para cada ciudad.
2. **¿De dónde lo puedo obtener?**:  Necesito datos de las tablas "Sales" y "Store Desc". De "Sales" necesito "Weekly_Sales" y "Store" (para unir con la otra tabla). De "Store Desc" necesito "city".
3. **¿Cómo lo quiero?**:  Primero, debo filtrar las ventas que ocurrieron en días festivos ("Holiday_Flag" = 1). Luego, agrupar las ventas por ciudad y calcular el promedio. Finalmente, ordenar los resultados de mayor a menor promedio y seleccionar la primera ciudad.

**Query SQL:**

```sql
SELECT sd.city 
FROM Sales s
JOIN "Store Desc" sd ON s.Store = sd.store
WHERE s."Holiday_Flag" = 1
GROUP BY sd.city
ORDER BY AVG(s."Weekly_Sales") DESC
LIMIT 1;
```

**Ejemplo 2:**

**Pregunta:** ¿Cuál es el tamaño promedio de las tiendas tipo "A" en Estados Unidos?

**Construcción de la Query:**

1. **¿Qué quiero?**: El tamaño promedio ("Size") de las tiendas.
2. **¿De dónde lo puedo obtener?**: Necesito la tabla "Stores".
3. **¿Cómo lo quiero?**: Debo filtrar las tiendas que son de tipo "A" y que se encuentran en Estados Unidos ("country" = "United States"). Luego, calcular el promedio del tamaño ("Size") de las tiendas. 

**Query SQL:**

```sql
SELECT AVG(st."Size") 
FROM Stores st
JOIN "Store Desc" sd ON st.Store = sd.store
WHERE st."Type" = 'A' AND sd.country = 'United States';
```

**Ejemplo 3:**

**Pregunta:** ¿Cuáles tiendas tuvieron ventas semanales superiores al promedio general en el mes de febrero de 2010?

**Construcción de la Query:**

1. **¿Qué quiero?**:  Los nombres de las tiendas ("Store") 
2. **¿De dónde lo puedo obtener?**: Necesito la tabla "Sales".
3. **¿Cómo lo quiero?**: Primero, calcular el promedio general de ventas semanales. Luego, filtrar las ventas del mes de febrero de 2010 y seleccionar las tiendas con ventas semanales superiores al promedio.

**Query SQL:**

```sql
SELECT s.Store
FROM Sales s
WHERE STRFTIME('%Y-%m', s.Date) = '2010-02' AND s."Weekly_Sales" > (SELECT AVG("Weekly_Sales") FROM Sales);
```

**Ejemplo 4:**

**Pregunta:** ¿Cuál es la temperatura promedio en los días que no son festivos para cada tipo de tienda?

**Construcción de la Query:**

1. **¿Qué quiero?**:  La temperatura promedio ("Temperature") para cada tipo de tienda ("Type").
2. **¿De dónde lo puedo obtener?**: Necesito datos de las tablas "Sales" y "Stores".
3. **¿Cómo lo quiero?**: Debo filtrar las ventas que ocurrieron en días no festivos ("Holiday_Flag" = 0). Luego, agrupar por tipo de tienda y calcular el promedio de temperatura.

**Query SQL:**

```sql
SELECT st.Type, AVG(s.Temperature) AS Promedio_Temperatura
FROM Sales s
JOIN Stores st ON s.Store = st.Store
WHERE s."Holiday_Flag" = 0
GROUP BY st.Type;
```

**Ejemplo 5:**

**Pregunta:** ¿Cuál es la tienda con el mayor índice de desempleo ("Unemployment") y cuál es su dirección?

**Construcción de la Query:**

1. **¿Qué quiero?**: El nombre de la tienda ("Store") y su dirección ("address").
2. **¿De dónde lo puedo obtener?**: Necesito datos de las tablas "Sales" y "Store Desc".
3. **¿Cómo lo quiero?**: Debo ordenar las ventas por índice de desempleo de forma descendente y tomar el primer registro.

**Query SQL:**

```sql
SELECT s.Store, sd.address
FROM Sales s
JOIN "Store Desc" sd ON s.Store = sd.store
ORDER BY s.Unemployment DESC
LIMIT 1;
```

Estos son solo algunos ejemplos, puedes generar muchas más preguntas y queries utilizando las diferentes columnas y combinaciones de tablas. Recuerda seguir los pasos del modelo para construir tus queries: define qué necesitas, de dónde obtenerlo y cómo lo quieres.
