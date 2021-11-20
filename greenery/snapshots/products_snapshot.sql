{% snapshot products_snapshot %}
{# Keep track on product stock/price #}
  {{
    config(
      target_schema='snapshots',
      unique_key="product_id",

      strategy='check',
      check_cols=['quantity', 'price'] 
    )
  }}

  SELECT * 
  FROM {{ source('raw_sources', 'products') }}

{% endsnapshot %}