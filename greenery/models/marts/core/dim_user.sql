{{
    config(
        materialized = 'view'
    )
}}


WITH users AS (
    SELECT * FROM {{ref('stg_postgres__users')}}
)

SELECT * FROM users