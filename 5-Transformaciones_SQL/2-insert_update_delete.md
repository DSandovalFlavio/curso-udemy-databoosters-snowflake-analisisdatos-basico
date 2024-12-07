## Manipulación de datos con SQL: INSERT, UPDATE, DELETE en Snowflake

A continuación, te presento ejemplos de cómo usar las sentencias `INSERT`, `UPDATE` y `DELETE` en Snowflake con las tablas "Sales", "Store Desc" y "Stores":

**INSERT:**

1. **Insertar una nueva tienda:**

```sql
INSERT INTO Stores(Store, Type, Size) 
VALUES (11, 'C', 180000);

INSERT INTO "Store Desc"(store, city, country, address) 
VALUES (11, 'Miami', 'United States', '123 Ocean Drive');
```
Este código inserta una nueva tienda con `Store` 11, `Type` 'C', `Size` 180000, ubicada en Miami, Estados Unidos, en la dirección '123 Ocean Drive'.

2. **Insertar un nuevo registro de ventas:**

```sql
INSERT INTO Sales(Store, Date, Weekly_Sales, Holiday_Flag, Temperature, Fuel_Price, CPI, Unemployment) 
VALUES (1, '2010-03-05', 1500000, 0, 48.5, 2.65, 211.4, 8.0);
```
Este código inserta un nuevo registro de ventas para la tienda 1 con la fecha '2010-03-05', ventas semanales de 1500000, sin ser día festivo, con una temperatura de 48.5, precio del combustible de 2.65, CPI de 211.4 y desempleo de 8.0.

**UPDATE:**

1. **Actualizar el tipo de una tienda:**

```sql
UPDATE Stores 
SET Type = 'B' 
WHERE Store = 11;
```
Este código actualiza el tipo de la tienda 11 a 'B'.

2. **Actualizar las ventas semanales de un registro específico:**

```sql
UPDATE Sales 
SET "Weekly_Sales" = 1650000 
WHERE Store = 1 AND Date = '2010-03-05';
```
Este código actualiza las ventas semanales a 1650000 para el registro de la tienda 1 con fecha '2010-03-05'.

**DELETE:**

1. **Eliminar una tienda:**

```sql
-- Primero eliminar de la tabla Sales, ya que tiene una foreign key a Stores
DELETE FROM Sales WHERE Store = 11;

-- Luego eliminar de la tabla "Store Desc"
DELETE FROM "Store Desc" WHERE store = 11;

-- Finalmente eliminar de la tabla Stores
DELETE FROM Stores WHERE Store = 11;
```
Este código elimina la tienda 11. **Importante:** Primero se eliminan los registros relacionados en la tabla `Sales` para mantener la integridad referencial, luego se elimina de la tabla `"Store Desc"` y finalmente de la tabla `Stores`.

2. **Eliminar registros de ventas anteriores a una fecha específica:**

```sql
DELETE FROM Sales WHERE Date < '2010-03-01';
```
Este código elimina todos los registros de ventas con fecha anterior al 1 de marzo de 2010.

**Consideraciones importantes al usar DELETE en Snowflake:**

* **Cuidado con los borrados accidentales:** Siempre revisa bien la condición `WHERE` antes de ejecutar un `DELETE` para evitar borrar datos que no deseas.
* **Snowflake Time Travel:** Puedes usar Time Travel para recuperar datos borrados accidentalmente dentro de un período de tiempo configurable.
* **Fail-safe:** Snowflake ofrece opciones de "fail-safe" que te permiten recuperar datos incluso después de que haya expirado el período de Time Travel.

Recuerda que estos son solo ejemplos básicos. Puedes combinar las sentencias `INSERT`, `UPDATE` y `DELETE` con cláusulas `WHERE` más complejas para realizar operaciones de manipulación de datos más sofisticadas. 
