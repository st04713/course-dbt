{{
    config(
        materialized = 'table'
    )
}}

WITH item_sess AS (
    SELECT * FROM {{ref('w3_int_item_sess')}}
)


SELECT
    product_id
    ,COUNT(DISTINCT session_id) AS num_session
    ,COUNT(DISTINCT CASE WHEN event_type='checkout' THEN session_id END) AS num_session_purchased
    ,COUNT(DISTINCT CASE WHEN event_type='checkout' THEN session_id END)/COUNT(DISTINCT session_id) AS conversion_rate
From item_sess
GROUP BY 1