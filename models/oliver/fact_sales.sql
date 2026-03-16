{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
) }}

SELECT
    dc.cust_key, 
    dd.date_key,
    ds.store_key, 
    dp.product_key,
    de.employee_key,
    ol.quantity, 
    ol.quantity*ol.unit_price as dollars_sold,
    ol.unit_price
FROM {{ source('oliver_landing', 'orderline') }} ol
INNER JOIN {{ source('oliver_landing', 'product') }} p ON ol.product_ID = p.product_ID
INNER JOIN {{ source('oliver_landing', 'orders') }} o ON ol.order_ID = o.order_ID
INNER JOIN {{ ref('oliver_dim_product') }} dp ON dp.product_ID = p.product_ID
INNER JOIN {{ ref('oliver_dim_store') }} ds ON o.store_id = ds.store_id
INNER JOIN {{ ref('oliver_dim_date') }} dd ON dd.date_day = o.order_date
INNER JOIN {{ ref('oliver_dim_customer') }} dc ON o.customer_id = dc.customerid
INNER JOIN {{ ref('oliver_dim_employee') }} de ON o.employee_id = de.employeeid
