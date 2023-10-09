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
        , COUNT(DISTINCT event_id) AS num_page_view
    FROM events
    WHERE event_type = 'page_view'
    GROUP BY 1
)

SELECT * FROM final