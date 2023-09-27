-- How long are people spending on our site ? 

{{
    config(
        materialized = 'view'
    )
}}

WITH events AS (
    SELECT * FROM {{ref('stg_postgres__events')}}
)

,final AS (
    SELECT 
     user_id
     , session_Id
     , SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_carts
     , SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS checkouts
     , SUM(CASE WHEN event_type = 'package_shipped' THEN 1 ELSE 0 END) AS package_shippeds
     , SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS page_views
     , MIN(created_at_utc) AS first_session_event_utc
     , MAX(created_at_utc) AS last_session_event_utc
    --  , datediff('minutes',MIN(created_at_utc),MAX(created_at_utc)) as mins_spent_session
    FROM events
    GROUP BY 1,2
)

SELECT * FROM final

-- dbt build -s +int_session_events_agg # upstream running 