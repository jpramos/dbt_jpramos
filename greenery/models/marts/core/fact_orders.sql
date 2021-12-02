{{
  config(
    materialized='table'
  )
}}

SELECT
  o.order_uuid,
  o.created_at_utc,
  o.order_cost,
  o.shipping_cost,
  o.order_total,
  o.status AS order_status,
  date_part('day',  o.delivered_at_utc) - date_part('day',o.created_at_utc) AS days_to_deliver,
  -- promo data
  pc.promo_name AS promo_code_name,
  pc.discount AS promo_code_discount,
  -- user data,
  concat_ws(' ', u.first_name, u.last_name) as user_name,
  u.email as user_email,
  u.phone_number as user_phone_number,
  -- shipping data
  o.tracking_uuid,
  o.shipping_service,
  a.address as delivery_address,
  a.zipcode as delivery_zipcode,
  a.state as delivery_state,
  a.country as delivery_country
FROM {{ ref('stg_orders') }} o
LEFT JOIN {{ ref('stg_promos') }} pc
  ON o.promo_name = pc.promo_name
LEFT JOIN {{ ref('stg_users') }} u
  ON o.user_uuid = u.user_uuid
left join {{ ref('stg_addresses') }} a
  on o.address_uuid = a.address_uuid 