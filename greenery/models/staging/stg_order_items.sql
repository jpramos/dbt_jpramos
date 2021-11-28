with source as (

    -- select * from {{ ref('order_items_snapshot') }}
    select * from {{ source('raw_sources', 'order_items') }}

),

renamed as (

    select
        order_id::varchar as order_uuid,
        product_id::varchar as product_uuid,
        quantity::int
        --dbt_valid_to is null as is_current_version,
        --row_number() over (partition by order_id, product_id 
        --                    order by dbt_valid_from) as version
    from source

)

select * from renamed