{{
  config(
    materialized='table'
  )
}}

{% set event_types = dbt_utils.get_query_results_as_dict("select distinct(event_type) from" ~ ref('stg_events'))['event_type'] %}

with product_session_agg as (
  select
    *,
    (number_of_product_add_to_cart::int::boolean and number_of_checkout::int::boolean) product_cart_and_checkout

    from {{ ref('int_sessions_products_agg') }}

)
select 
    p.name as product_name,
    psa.*
from {{ ref('stg_products') }} p
left join product_session_agg psa
on psa.product_uuid = p.product_uuid