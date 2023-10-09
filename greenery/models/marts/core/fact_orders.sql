{{
    config(
        materialized = 'view'
    )
}}

WITH orders AS (
    SELECT * FROM {{ref('stg_postgres__orders')}}
)

