with source as (

    select * from {{ source('raw_sources', 'orders') }}

),

renamed as (

    select
        order_id::varchar as order_uuid,
        promo_id::varchar as promo_uuid,
        user_id::varchar as user_uuid,
        address_id::varchar as addres_uuid,
        created_at::timestamptz as created_at_utc,
        order_cost::float,
        shipping_cost::float,
        order_total::float,
        tracking_id::varchar as tracking_uuid,
        shipping_service::varchar,
        estimated_delivery_at::timestamptz as estimated_delivery_at_utc,
        delivered_at::timestamptz as delivery_at_utc,
        status::varchar
    from source

)

select * from renamed