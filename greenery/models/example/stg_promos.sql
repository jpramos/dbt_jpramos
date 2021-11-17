with source as (

    select * from {{ source('raw', 'promos') }}

),

renamed as (

    select
        promo_id,
        discout as discount,
        status
    from source

)

select * from renamed