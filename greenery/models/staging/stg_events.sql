with source as (

    select * from {{ source('raw_sources', 'events') }}

),

renamed as (

    select
        event_id::varchar as event_uuid,
        session_id::varchar as session_uuid,
        user_id::varchar as user_uuid,
        event_type::varchar,
        page_url::varchar,
        created_at::timestamptz as created_at_utc
    from source

)

select * from renamed