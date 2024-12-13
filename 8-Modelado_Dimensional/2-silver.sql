CREATE OR REPLACE VIEW `cogent-tree-369319.codigo_facilito_dw.vw_silver_sales_report` AS (
    SELECT 
    -- cast(order_date AS DATE) AS order_date,
    cast(order_date AS DATE) AS order_date,
    SPLIT(purchase_address, ', ')[SAFE_OFFSET(1)] AS city,
    product, category,
    SUM(quantity_ordered) AS quantity_ordered, SUM(quantity_ordered * price_each) AS sales
    FROM `cogent-tree-369319.codigo_facilito_dw.sales_report_hist`
    GROUP BY 1,2,3,4
    ORDER BY order_date
)