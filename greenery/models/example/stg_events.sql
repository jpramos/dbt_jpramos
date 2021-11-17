with source as (

    select * from {{ source('raw', 'events') }}

),

renamed as (

    select
        event_id,
        session_id,
        user_id,
        event_type,
        page_url,
        created_at
    from source

)

select * from renamed