{{
  config(
    materialized='table'
  )
}}

select
    event_uuid,
    session_uuid,
    user_uuid,
    event_type,
    page_url,
    page_type,
    created_at_utc
from {{ ref('stg_events')}}