WITH source AS (
    SELECT * FROM {{ source('postgres','orders')}}
)

, renamed_recast AS (
    SELECT
        order_id,
        user_Id AS user_guid,
        created_at AS created_at_utc,
        delivered_at AS delivered_at_utc,
        status
    FROM source
)

SELECT * FROM renamed_recast