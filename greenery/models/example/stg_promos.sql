with source as (

    select * from {{ source('raw_sources', 'promos') }}

),

renamed as (

    select
        promo_id::varchar as promo_uuid,
        discout::int as discount,
        status::varchar
    from source

)

select * from renamed