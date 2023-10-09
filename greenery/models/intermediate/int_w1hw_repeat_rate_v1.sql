{{
    config(
        materialized = 'view'
    )
}}

WITH orders AS (
    SELECT * FROM {{ref('stg_postgres__orders')}}
)

, order_cohorts AS (
    SELECT 
        user_guid
        , count(distinct order_id) AS user_orders
    FROM orders 
    GROUP BY 1
)

, user_bucket AS (
    SELECT
        user_guid
        , CASE WHEN user_orders = 1 THEN 1 ELSE 0 END AS has_one_purchase
        , CASE WHEN user_orders >= 2 THEN 1 ELSE 0 END AS has_two_plus_purchases
    FROM order_cohorts
     
)

SELECT 
    COUNT(DISTINCT user_guid) AS num_users_purchase
    , SUM(has_two_plus_purchases) AS num_users_has_two_plus_purchases
    , COALESCE(SUM(has_two_plus_purchases)/COUNT(DISTINCT user_guid),NULL) AS repeat_rate
FROM user_bucket

-- cd greenery
-- dbt build -s +int_w1hw_repeat_rate_v1.sql # upstream running