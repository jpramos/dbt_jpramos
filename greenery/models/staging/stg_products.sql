with source as (

    select * from {{ source('raw_sources', 'products') }}

),

renamed as (

    select
        product_id::varchar as product_uuid,
        name::varchar,
        price::float,
        quantity::float
    from source

)

select * from renamed