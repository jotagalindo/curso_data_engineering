SELECT
  {{ dbt_utils.generate_surrogate_key(['address_id']) }} AS address_id,
  zipcode,
  country,
  address,
  state,
{{ add_fivetran_metadata() }}
FROM {{ source('sql_server_dbo', 'addresses') }}
WHERE _fivetran_deleted IS NULL
