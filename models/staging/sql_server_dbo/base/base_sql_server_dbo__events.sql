SELECT
  {{ dbt_utils.generate_surrogate_key(['event_id']) }} AS event_id,
  page_url,
  INITCAP(REGEXP_REPLACE(event_type, '[^a-zA-Z0-9]+', ' ')) as event_type,
  user_id,
  product_id,
  session_id,
  created_at,
  order_id,
{{ add_fivetran_metadata() }}
FROM {{ source('sql_server_dbo', 'events') }}
ORDER BY created_at