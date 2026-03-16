{{ config(
    materialized = 'table',
    schema = 'dw_oliver'
    )
}}

SELECT
customer_id as cust_key,
customer_id as customerid ,
first_name as firstname,
last_name as lastname,
phone_number as phonenumber,
email,
state
FROM {{ source('oliver_landing', 'customer') }}