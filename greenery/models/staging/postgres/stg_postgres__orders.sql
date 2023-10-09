WITH source AS (
    SELECT * FROM {{ source('postgres','orders')}}
)

, renamed_recast AS (
    SELECT
        order_id,
        user_Id AS user_guid,
        address_id AS order_address_id,
        created_at AS created_at_utc,
        DATE(created_at) AS created_date_utc,
        order_cost,
        shipping_cost,
        order_total,
        delivered_at AS delivered_at_utc,
        status
    FROM source
)

SELECT * FROM renamed_recast