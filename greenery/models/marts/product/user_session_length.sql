--- JAKES : How long are people spending on our site ? ---


{{
    config(
        materialized = 'view'
    )
}}

with fact_user_sessions AS (
    SELECT * FROM {{ref('fact_user_sessions')}}
)

SELECT AVG(session_length_minutes) AS avg_session_length_minutes FROM fact_user_sessions

-- dbt build -s +user_session_length # upstream running, terminal