{{
    config(
        materialized = 'table'
    )
}}

with session_events_agg AS (
    SELECT * FROM {{ref('int_session_events_agg')}}
)

,users AS (
    SELECT * FROM {{ref('stg_postgres__users')}}
)

,addresses AS (
    SELECT * FROM {{ref('stg_postgres__addresses')}}
)

SELECT
    s.session_Id
    , s.user_guid
    , u.email
    , u.phone_number
    , a.address_id
    , a.zipcode
    , s.page_views
    , s.add_to_carts
    , s.package_shippeds
    , s.first_session_event_utc
    , s.last_session_event_utc
    , datediff('minute', first_session_event_utc, last_session_event_utc) as session_length_minutes
FROM session_events_agg AS s
LEFT JOIN users AS u
    ON s.user_guid = u.user_guid
LEFT JOIN addresses AS a
    ON u.address_id = a.address_id

-- dbt build -s +fct_user_sessions # upstream running, terminal
-- SELECT * FROM 