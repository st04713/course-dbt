---  SALES + DIGITAL ACTIVITIES  ---
--- metrics: cnt_page_view, cnt_order, sum_quantity, revenue
--- freq: daily
--- slice&dice_level: product_id

{{
    config(
        materialized = 'table'
    )
}}

with order_items_agg AS (
    SELECT * FROM {{ref('w2_int_order_items_agg')}}
)

,page_views_agg  AS (
    SELECT * FROM {{ref('w2_int_page_views_agg')}}
)


SELECT
    oi.*
    , pv.num_page_view
FROM order_items_agg AS oi
LEFT JOIN page_views_agg AS pv
    ON oi.product_id = pv.product_id
    AND oi.created_date_utc = pv.created_date_utc

