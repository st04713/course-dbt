--- metrics: cnt_unique_order_id, sum_quantity 
--- freq: daily
--- slice&dice_level: product_id

{{
    config(
        materialized = 'view'
    )
}}

WITH order_items AS (
    SELECT * FROM {{ref('stg_postgres__events')}}
)

,base AS (
    SELECT 
        product_id,
        
        , COUNT(DISTINCT order_id) AS num_order
        , SUM(quantity) AS total_quantity
    FROM order_items
    GROUP BY 1
)

SELECT * FROM final