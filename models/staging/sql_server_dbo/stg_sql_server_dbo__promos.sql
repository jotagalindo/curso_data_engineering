SELECT
  {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id,
  promo_id as promo_description,
  discount,
  CASE
    WHEN lower(status) = 'active' THEN 1
    WHEN lower(status) = 'inactive' THEN 0
    ELSE NULL
  END as status
--   convert_timezone('UTC', _fivetran_synced) as _fivetran_synced
FROM {{ source('sql_server_dbo', 'promos') }}
WHERE _fivetran_deleted IS NULL

UNION ALL

SELECT
  {{ dbt_utils.generate_surrogate_key(["'sin-promo'"]) }} as promo_id,
  'sin-promo' as promo_description,
  0 as discount,
  1 as status
--   convert_timezone('UTC', _fivetran_synced) as _fivetran_synced