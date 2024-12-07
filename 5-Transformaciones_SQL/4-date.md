## Ejemplos de funciones de transformación de datos - Date en Snowflake:

**1. Extraer el mes de la fecha:**

```sql
SELECT 
    MONTH(Date) AS mes
FROM 
    Sales;
```

Este ejemplo usa `MONTH` para extraer el número de mes de la columna `Date`.

**2. Calcular la diferencia en días entre dos fechas:**

```sql
SELECT 
    DATEDIFF(day, '2010-02-05', Date) AS diferencia_dias
FROM 
    Sales;
```

Este ejemplo usa `DATEDIFF` para calcular la diferencia en días entre la fecha '2010-02-05' y la fecha en la columna `Date`.

**3. Agregar un mes a la fecha:**

```sql
SELECT 
    DATEADD(month, 1, Date) AS fecha_siguiente_mes
FROM 
    Sales;
```

Este ejemplo usa `DATEADD` para agregar un mes a la fecha en la columna `Date`.

**4. Obtener el último día del mes:**

```sql
SELECT 
    LAST_DAY(Date) AS ultimo_dia_mes
FROM 
    Sales;
```

Este ejemplo usa `LAST_DAY` para obtener el último día del mes de la fecha en la columna `Date`.

**5. Extraer el día de la semana:**

```sql
SELECT 
    DAYOFWEEK(Date) AS dia_semana
FROM 
    Sales;
```

Este ejemplo usa `DAYOFWEEK` para obtener el día de la semana (1=Domingo, 7=Sábado) de la fecha en la columna `Date`.

**6. Formatear la fecha como "Mes Día, Año":**

```sql
SELECT 
    TO_CHAR(Date, 'MMMM DD, YYYY') AS fecha_formateada
FROM 
    Sales;
```

Este ejemplo usa `TO_CHAR` para formatear la fecha en la columna `Date` como "Mes Día, Año" (ej. "Febrero 05, 2010").

**7. Truncar la fecha al primer día del mes:**

```sql
SELECT 
    DATE_TRUNC('month', Date) AS primer_dia_mes
FROM 
    Sales;
```

Este ejemplo usa `DATE_TRUNC` para truncar la fecha en la columna `Date` al primer día del mes.

**8. Calcular la edad de un registro en años:**

```sql
SELECT 
    FLOOR(DATEDIFF(day, Date, CURRENT_DATE()) / 365.25) AS edad_registro
FROM 
    Sales;
```

Este ejemplo calcula la diferencia en días entre la fecha del registro y la fecha actual, la divide entre 365.25 para obtener la edad en años y usa `FLOOR` para redondear hacia abajo.

Estos son solo algunos ejemplos de cómo puedes usar las funciones de transformación de fechas en Snowflake. Puedes combinar estas funciones con otras funciones de SQL para realizar análisis y transformaciones de datos más complejas.
