SELECT
  {{ dbt_utils.generate_surrogate_key(['product_id']) }} AS product_id,
  price,
  name,
  inventory,
{{ add_fivetran_metadata() }}
FROM {{ source('sql_server_dbo', 'products') }}
WHERE _fivetran_deleted IS NULL
