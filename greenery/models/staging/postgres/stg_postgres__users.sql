-- dbt perfers cte style 
WITH source AS (
    SELECT * FROM {{ source('postgres','users')}}
)

, renamed_recast AS (
    SELECT 
        user_Id AS user_guid
        , created_at AS created_at_utc
        , updated_At AS updated_at_utc
        , email
        , phone_number
        , address_id
    FROM source
)

select * from renamed_recast

-- dbt run -m stg_postgres__users
-- dbt test -m stg_postgres__users 

--- Terminal --- 
-- cd greenery
-- dbt build -m stg_postgres__users # test from _stg_postgres__users.yml
--- SQL --- 
-- select * from dev_db.dbt_ittigoonsaithonnghotmailcom.stg_postgres__users limit 10 -- check data
