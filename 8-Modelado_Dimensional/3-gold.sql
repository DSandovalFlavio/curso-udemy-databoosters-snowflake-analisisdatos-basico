CREATE OR REPLACE VIEW `cogent-tree-369319.codigo_facilito_dw.vw_gold_dim_product` AS (
    SELECT 
        RANK() OVER (ORDER BY product, category) AS product_id,
        product, category
    FROM 
        `cogent-tree-369319.codigo_facilito_dw.vw_silver_sales_report` 
    GROUP BY 
        product, category;
    );

CREATE OR REPLACE VIEW `cogent-tree-369319.codigo_facilito_dw.vw_gold_dim_city` AS (
    SELECT 
        RANK() OVER (ORDER BY city) AS city_id,
        city
    FROM 
        `cogent-tree-369319.codigo_facilito_dw.vw_silver_sales_report` 
    GROUP BY 
        city;
    );

CREATE OR REPLACE VIEW `cogent-tree-369319.codigo_facilito_dw.vw_gold_dim_calendar` AS (
    SELECT
        fecha,
        EXTRACT(DAY FROM fecha) AS dia,
        EXTRACT(MONTH FROM fecha) AS mes,
        EXTRACT(YEAR FROM fecha) AS anio,
        EXTRACT(DAYOFWEEK FROM fecha) AS dia_de_la_semana,
        EXTRACT(WEEK FROM fecha) AS semana_del_anio,
        CASE
            WHEN EXTRACT(DAYOFWEEK FROM fecha) IN (1, 7) THEN 'Fin de semana'
            ELSE 'Día laborable'
        END AS tipo_dia
    FROM (
        SELECT DISTINCT
            CAST(fecha AS DATE) AS fecha
        FROM
            `cogent-tree-369319.codigo_facilito_dw.vw_silver_sales_report`
    ) AS fechas_disponibles;
);

CREATE OR REPLACE VIEW `cogent-tree-369319.codigo_facilito_dw.vw_gold_fact_sales` AS (
    SELECT 
        fecha, product_id, city_id, quantity_ordered, sales
    FROM 
        `cogent-tree-369319.codigo_facilito_dw.vw_silver_sales_report`
    JOIN 
        `cogent-tree-369319.codigo_facilito_dw.vw_gold_dim_product` 
    USING 
        (product, category)
    JOIN 
        `cogent-tree-369319.codigo_facilito_dw.vw_gold_dim_city` 
    USING 
        (city)
);