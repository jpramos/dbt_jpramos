{{
  config(
    materialized='table'
  )
}}


{% set event_types = dbt_utils.get_query_results_as_dict("select distinct(event_type) from" ~ ref('stg_events'))['event_type'] %}

with get_product_uuid as (

  select
    *,
    split_part(page_url, '/',5) as product_uuid
    from {{ ref('stg_events') }}
)

select
    session_uuid,
    event_type,
    product_uuid,
    min(created_at_utc) over w_session as session_begin_at,
    max(created_at_utc) over w_session as session_end_at,

    {% for et in event_types %}
    
    sum(case when event_type = '{{ et }}' then 1 else 0 end) over w_session as number_of_{{ et }},

    sum(case when event_type = '{{ et }}' then 1 else 0 end) over w_session_product as number_of_product_{{ et }}
    
    {% if not loop.last %} , {% endif %}
    {% endfor %}

from get_product_uuid
window w_session as (partition by session_uuid),
       w_session_product as (partition by session_uuid, product_uuid)
