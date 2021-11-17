with source as (

    select * from {{ source('raw', 'addresses') }}

),

renamed as (

    select
        address_id,
        address,
        zipcode,
        state,
        country
    from source

)

select * from renamed