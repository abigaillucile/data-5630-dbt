{{ config(
    materialized = 'table',
    schema = 'dw_ecoessentials_ecoessentials_transactional_db'
    )
}}

SELECT
{{ dbt_utils.generate_surrogate_key(['product_id', 'product_name']) }} as product_key,
product_id, 
product_type, 
product_name
FROM {{ source('ecoessentials_landing', 'product') }}