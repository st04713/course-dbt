{{
    config(
        materialized = 'view'
    )
}}


WITH products AS (
    SELECT * FROM {{ref('stg_postgres__products')}}
)

SELECT * FROM products