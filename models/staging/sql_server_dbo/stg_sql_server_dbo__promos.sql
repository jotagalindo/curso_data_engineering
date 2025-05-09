WITH base AS (
    SELECT
    promo_id,
    INITCAP({{ clean_string('promo_description', ' ') }}) as promo_description,
    discount,
    status_id,
    is_deleted,
    date_load
    FROM {{ ref('base_sql_server_dbo__promos') }}
)

SELECT
  *
FROM base

UNION ALL

SELECT
  {{ dbt_utils.generate_surrogate_key(["'no_promo'"]) }} as promo_id,
  'No Promo' as promo_description,
  0 as discount,
  {{ dbt_utils.generate_surrogate_key([1]) }} as status_id,
  false as is_deleted,
  convert_timezone('UTC', GETDATE()) as date_load