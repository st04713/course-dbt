WITH source AS (
    SELECT * FROM {{ source('postgres','events')}}
)

, renamed_recast AS (
    SELECT
        EVENT_ID,
        SESSION_ID,
        USER_ID AS USER_GUID,
        PRODUCT_ID,
        ORDER_ID,
        CREATED_AT AS created_at_utc,
        DATE(CREATED_AT) AS created_date_utc,
        EVENT_TYPE
    FROM source
)

SELECT * FROM renamed_recast
