{{
  config(
    materialized='table'
  )
}}

with orders_per_user as (
        select 
            user_uuid,
            count(distinct order_uuid) as n_orders,
            avg(order_total) as avg_order_total
        from dbt_jpramos.stg_orders
        group by 1
), user_repeat_rate as (
  select 
    user_uuid,
    round(100.0*sum(case when n_orders >=2 then 1 else 0 end)/count(*), 2) as repeat_rate
    from orders_per_user
    group by 1
)
select
    u.user_uuid,
    o.n_orders,
    r.repeat_rate,
    o.avg_order_total
from {{ ref("stg_users") }} u
left join orders_per_user o using(user_uuid)
left join user_repeat_rate r using (user_uuid)
