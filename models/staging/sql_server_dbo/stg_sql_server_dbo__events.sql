WITH base AS (
  SELECT * FROM {{ ref('base_sql_server_dbo__events') }}
)

SELECT
  event_id,
  page_url,
  event_type_id,
  user_id,

  -- Limpiar product_id vacío y aplicar surrogate
  {{ dbt_utils.generate_surrogate_key([
    "CASE WHEN TRIM(product_id) = '' THEN 'no_product' ELSE product_id END"
  ]) }} AS product_id,

  -- Limpiar order_id vacío y aplicar surrogate
  {{ dbt_utils.generate_surrogate_key([
    "CASE WHEN TRIM(order_id) = '' THEN 'no_order' ELSE order_id END"
  ]) }} AS order_id,
  {{ dbt_utils.generate_surrogate_key(['session_id']) }} as session_id,
  CONVERT_TIMEZONE('UTC', created_at) as created_at,
  is_deleted,
  date_load
FROM base
ORDER BY created_at
