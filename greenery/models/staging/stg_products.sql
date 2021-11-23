with source as (

    select * from {{ ref('products_snapshot') }}

),

renamed as (

    select
        product_id::varchar as product_uuid,
        name::varchar,
        price::float,
        quantity::float,
        dbt_valid_to is null as is_current_version,
        row_number() over (partition by product_id 
                            order by dbt_valid_from) as version
    from source

)

select * from renamed