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