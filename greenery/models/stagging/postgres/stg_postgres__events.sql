WITH source AS (
    SELECT * FROM {{ source('postgres','events')}}
)

, renamed_recast AS (
    SELECT
        EVENT_ID,
        SESSION_ID,
        USER_ID AS user_guid,
        CREATED_AT AS created_at_utc
    FROM source
)

SELECT * FROM renamed_recast
