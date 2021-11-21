{% snapshot promos_snapshot %}
{# Keep track on the status of promotions #}
  {{
    config(
      target_schema='snapshots',
      unique_key='promo_id',

      strategy='check',
      check_cols=['status', 'discout'] 
    )
  }}

  SELECT * 
  FROM {{ source('raw_sources', 'promos') }}

{% endsnapshot %}