WITH base AS (
  SELECT * FROM {{ ref('base_sql_server_dbo__addresses') }}
)

SELECT
    address_id,
    zipcode,
    country,
    address,
    state_id,
    is_deleted,
    date_load
FROM base