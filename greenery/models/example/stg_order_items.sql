with source as (

    select * from {{ source('raw', 'order_items') }}

),

renamed as (

    select
        order_id,
        product_id,
        quantity
    from source

)

select * from renamed