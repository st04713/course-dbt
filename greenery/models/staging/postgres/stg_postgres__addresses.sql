-- dbt perfers cte style 
WITH source AS (
    SELECT * FROM {{ source('postgres','addresses')}}
)

, renamed_recast AS (
    SELECT 
        address_id
        , zipcode
    FROM source
)

select * from renamed_recast