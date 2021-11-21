{% snapshot orders_snapshot %}
{# Keep track on the order status and the estimated delivery #}
  {{
    config(
      target_schema='snapshots',
      unique_key='order_id',

      strategy='check',
      check_cols=['status', 'estimated_delivery_at']
    )
  }}

  SELECT * 
  FROM {{ source('raw_sources', 'orders') }}

{% endsnapshot %}