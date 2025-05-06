WITH base AS (
  SELECT * FROM {{ ref('base_sql_server_dbo__addresses') }}
)

SELECT
  *
FROM base