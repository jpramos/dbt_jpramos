{{
  config(
    materialized='table'
  )
}}

with agg_data as (
    select
        p.product_uuid,
        date_trunc('day', o.created_at_utc) as day,
        sum(ol.quantity) as quantity_ordered
    from {{ ref('stg_products')}} p
    left join {{ ref('stg_order_items')}} ol using (product_uuid)
    left join {{ ref('stg_orders') }} o using (order_uuid)
    group by 1, 2
)
select
    p.product_uuid,
    p.name,
    a.day,
    p.quantity,
    a.quantity_ordered,
    p.quantity - a.quantity_ordered as remaining_stock
from {{ ref('stg_products') }} as p
left join agg_data a using (product_uuid)

