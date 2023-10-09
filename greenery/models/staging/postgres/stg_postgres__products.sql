WITH source AS (
    SELECT * FROM {{ source('postgres','products')}}
)

, renamed_recast AS (
    SELECT
        *
    FROM source
)

SELECT * FROM renamed_recast