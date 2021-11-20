with source as (

    select * from {{ source('raw_sources', 'order_items') }}

),

renamed as (

    select
        order_id::varchar as order_uuid,
        product_id::varchar as product_uuid,
        quantity::int
    from source

)

select * from renamed