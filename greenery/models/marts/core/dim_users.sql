{{
  config(
    materialized='table'
  )
}}

select 
    u.user_uuid,
    u.first_name,
    u.last_name,
    email,
    phone_number,
    created_at_utc,
    updated_at_utc,
    a.address as user_address,
    a.zipcode as user_zipcode,
    a.state as user_state,
    a.country as user_country
from {{ ref('stg_users') }} as u
left join {{ ref('stg_addresses' )}} as a
using (address_uuid)