WITH base AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['status']) }} as status_id,
        INITCAP(REGEXP_REPLACE(status, '[^a-zA-Z0-9]+', ' ')) as status_description
    FROM {{ ref('base_sql_server_dbo__orders') }}
)

SELECT
  *
FROM base