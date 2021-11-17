with source as (

    select * from {{ source('raw', 'products') }}

),

renamed as (

    select
        product_id,
        name,
        price,
        quantity
    from source

)

select * from renamed