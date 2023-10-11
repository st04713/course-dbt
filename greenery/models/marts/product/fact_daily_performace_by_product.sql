---  SALES + DIGITAL ACTIVITIES  ---
--- metrics: cnt_page_view, cnt_order, sum_quantity, revenue, purchased session conversion rate
--- freq: daily
--- slice&dice_level: product_id

{{
    config(
        materialized = 'table'
    )
}}

with sale_agg AS (
    SELECT * FROM {{ref('w2_int_sale_agg')}}
)

,web_agg  AS (
    SELECT * FROM {{ref('w2_int_web_agg')}}
)


SELECT
    s.*
    ,d.num_event_pageview
    ,d.num_session
    ,d.num_session_purchased
    ,d.conversion_rate
FROM sale_agg AS s
LEFT JOIN web_agg AS d
    ON s.product_id = d.product_id
    AND s.created_date_utc = d.created_date_utc

