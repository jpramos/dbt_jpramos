{{
  config(
    materialized='table'
  )
}}

{% set event_types = dbt_utils.get_query_results_as_dict("select distinct(event_type) from" ~ ref('stg_events'))['event_type'] %}

select
    --distinct on (session_uuid)
    session_uuid,
    min(session_begin_at),
    max(session_end_at),

    {{ count_events(event_types) }}
    
from {{ ref('int_sessions_products_agg') }}
{{ dbt_utils.group_by(1) }}