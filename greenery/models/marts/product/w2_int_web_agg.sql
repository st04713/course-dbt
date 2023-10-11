---  DIGITAL ACTIVITIES  ---
--- metrics: cnt_page_view, cnt_session, cnt_purchased_session
--- freq: daily
--- slice&dice_level: product_id
{{
    config(
        materialized = 'view'
    )
}}

WITH items_sess AS (
    SELECT * FROM {{ref('w3_int_item_sess')}}
)


,items_sess_agg AS (
    SELECT
        product_id
        ,created_date_utc
        ,COUNT(DISTINCT CASE WHEN event_type='page_view' THEN event_id END) AS num_event_pageview
        ,COUNT(DISTINCT session_id) AS num_session
        ,COUNT(DISTINCT CASE WHEN event_type='checkout' AND order_id IS NOT NULL THEN session_id END) AS num_session_purchased
        ,COUNT(DISTINCT CASE WHEN event_type='checkout' AND order_id IS NOT NULL THEN session_id END)/COUNT(DISTINCT session_id) AS conversion_rate
    FROM items_sess
    GROUP BY 1,2
)

SELECT * FROM items_sess_agg