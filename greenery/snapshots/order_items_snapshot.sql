{% snapshot order_items_snapshot %}
{# Keep track on changes on quantity of product in an order #}
  {{
    config(
      target_schema='snapshots',
      unique_key="order_id||'-'||product_id",

      strategy='check',
      check_cols=['quantity'] 
    )
  }}

  SELECT * 
  FROM {{ source('raw_sources', 'order_items') }}

{% endsnapshot %}