{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    dc.customerid, 
    dd.date_day,
    dd.quarter,
    ds.store_id, 
    ds.store_name,
    dp.product_name,
    de.employeeid,
    fs.quantity, 
    fs.dollars_sold
FROM {{ ref('fact_sales') }} fs
INNER JOIN {{ ref('oliver_dim_product') }} dp ON fs.product_key = dp.product_key
INNER JOIN {{ ref('oliver_dim_store') }} ds ON fs.store_key = ds.store_key
INNER JOIN {{ ref('oliver_dim_date') }} dd ON fs.date_key = dd.date_key
INNER JOIN {{ ref('oliver_dim_customer') }} dc ON fs.cust_key = dc.cust_key
INNER JOIN {{ ref('oliver_dim_employee') }} de ON fs.employee_key = de.employee_key
