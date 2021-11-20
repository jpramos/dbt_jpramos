{% snapshot promos_snapshot %}
{# Keep track on the status of promotions #}
  {{
    config(
      target_schema='snapshots',
      unique_key='promo_id',

      strategy='check',
      check_cols=['status'] 
    )
  }}

  SELECT * 
  FROM {{ source('raw_sources', 'promos') }}

{% endsnapshot %}