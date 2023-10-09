---  DIGITAL ACTIVITIES  ---
--- metrics: cnt_page_view
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

,final AS (
    SELECT 
        product_id
        , created_date_utc
        , COUNT(DISTINCT event_id) AS num_page_view
    FROM events
    WHERE event_type = 'page_view'
    GROUP BY 1,2
)

SELECT * FROM final