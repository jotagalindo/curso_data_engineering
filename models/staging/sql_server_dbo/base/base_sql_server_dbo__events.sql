SELECT
  {{ dbt_utils.generate_surrogate_key(['event_id']) }} AS event_id,
  page_url,
  {{ clean_string('event_type', '_') }} AS event_type,
  {{ dbt_utils.generate_surrogate_key(['user_id']) }} as user_id,
  product_id,
  order_id,
  session_id,
  created_at,
{{ add_fivetran_metadata() }}
FROM {{ source('sql_server_dbo', 'events') }}
ORDER BY created_at