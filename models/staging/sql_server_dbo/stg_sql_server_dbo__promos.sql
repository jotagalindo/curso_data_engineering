WITH base AS (
  SELECT * FROM {{ ref('base_sql_server_dbo__promos') }}
)

SELECT
  *
FROM base

UNION ALL

SELECT
  {{ dbt_utils.generate_surrogate_key(["'sin-promo'"]) }} as promo_id,
  'No Promo' as promo_description,
  0 as discount,
  {{ dbt_utils.generate_surrogate_key([1]) }} as status_id,
  convert_timezone('UTC', GETDATE()) as date_load