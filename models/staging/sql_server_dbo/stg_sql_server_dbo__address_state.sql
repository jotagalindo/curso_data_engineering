WITH base AS (
  SELECT * FROM {{ ref('base_sql_server_dbo__addresses') }}
)

SELECT
    DISTINCT
    state_id,
    state_description
FROM base
