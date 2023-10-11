--- SALES --- 
--- metrics: cnt_unique_order_id, sum_quantity 
--- freq: daily
--- slice&dice_level: product_id

{{
    config(
        materialized = 'view'
    )
}}

WITH order_items AS (
    SELECT * FROM {{ref('stg_postgres__order_items')}}
)

, orders AS (
    SELECT * FROM {{ref('stg_postgres__orders')}}
)

, products AS (
    SELECT * FROM {{ref('stg_postgres__products')}}
)


,final AS (
    SELECT 
        oi.product_id
        , o.created_date_utc
        , COUNT(DISTINCT oi.order_id) AS num_order
        , SUM(oi.quantity) AS total_quantity
        , SUM(oi.quantity * p.price) AS revenue
    FROM order_items AS oi
    LEFT JOIN orders AS o
        ON oi.order_id = o.order_id
    LEFT JOIN products AS p
        ON oi.product_id = p.product_id
    GROUP BY 1,2
)

SELECT * FROM final