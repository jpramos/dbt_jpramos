
{# I would not enable an update on addresses as #}
{# this would generate data inconsistency on older instances. #}
{# In that case snapshots seems irrelevant. #}

with source as (

    select * from {{ source('raw_sources', 'addresses') }}

),

renamed as (

    select
        address_id::varchar as address_uuid,
        address::varchar,
        zipcode::int,
        state::varchar,
        country::varchar
    from source

)

select * from renamed