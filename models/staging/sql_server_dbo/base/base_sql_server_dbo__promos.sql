SELECT
  {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id,
  INITCAP(REGEXP_REPLACE(promo_id, '[^a-zA-Z0-9]+', ' ')) as promo_description,
  discount,
  CASE
    WHEN lower(status) = 'active' THEN {{ dbt_utils.generate_surrogate_key([1]) }}
    ELSE {{ dbt_utils.generate_surrogate_key([0]) }}
  END as status_id,
  convert_timezone('UTC', _fivetran_synced) as date_load
FROM {{ source('sql_server_dbo', 'promos') }}
-- WHERE _fivetran_deleted IS NULL