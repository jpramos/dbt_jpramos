{% snapshot users_snapshot %}
{# Keep track on updates of users information #}
  {{
    config(
      target_schema='snapshots',
      unique_key='user_id',

      strategy='timestamp',
      updated_at='updated_at'
    )
  }}

  SELECT * 
  FROM {{ source('raw_sources', 'users') }}

{% endsnapshot %}