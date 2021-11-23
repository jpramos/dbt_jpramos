with source as (

    select * from {{ ref('promos_snapshot') }}

),

renamed as (

    select
        promo_id::varchar as promo_uuid,
        discout::int as discount,
        status::varchar,
        dbt_valid_to is null as is_current_version,
        row_number() over (partition by promo_id 
                            order by dbt_valid_from) as version
    from source

)

select * from renamed