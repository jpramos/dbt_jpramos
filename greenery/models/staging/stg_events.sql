
{# Snapshots seems irrelevant here. #}

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
        case
            when page_url ~ '.*product.*' then 'product'
            when page_url ~ '.*signup.*' then 'signup'
            when page_url ~ '.*checkout.*' then 'checkout'
            when page_url ~ '.*shipping.*' then 'shipping'
            when page_url ~ '.*browse.*' then 'browse'
            else 'homepage'
        end::varchar as page_type,
        created_at::timestamptz as created_at_utc
    from source

)

select * from renamed