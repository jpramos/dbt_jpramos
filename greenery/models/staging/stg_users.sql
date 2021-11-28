with source as (

    -- select * from {{ ref('users_snapshot') }}
    select * from {{ source('raw_sources', 'users') }}

),

renamed as (

    select
        user_id::varchar as user_uuid,
        first_name::varchar,
        last_name::varchar,
        email::varchar,
        phone_number::varchar,
        created_at::timestamptz as created_at_utc,
        updated_at::timestamptz as updated_at_utc,
        address_id::varchar as address_uuid
        -- dbt_valid_to is null as is_current_version,
        -- row_number() over (partition by user_id 
        --                     order by dbt_valid_from) as version
    from source

)

select * from renamed