WITH source AS (
    SELECT * FROM {{ source('postgres','order_items')}}
)

, renamed_recast AS (
    SELECT
        *
    FROM source
)

SELECT * FROM renamed_recast