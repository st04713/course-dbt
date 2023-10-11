---  DIGITAL ACTIVITIES  ---
--- metrics: cnt_page_view, cnt_session, cnt_purchased_session
--- freq: daily
--- slice&dice_level: product_id
{{
    config(
        materialized = 'view'
    )
}}

WITH events AS (
    SELECT * FROM {{ref('stg_postgres__events')}}
)

,order_items AS (
    SELECT * FROM {{ref('stg_postgres__order_items')}}
)


,items_sess AS (
    SELECT
        e.event_id
        ,e.created_date_utc
        ,e.session_id
        ,e.event_type
        ,e.order_id
        ,CASE WHEN e.product_id IS NULL THEN oi.product_id ELSE e.product_id END AS product_id
    FROM events AS e
    LEFT JOIN order_items AS oi
    ON e.order_id = oi.order_id
)

SELECT * FROM items_sess