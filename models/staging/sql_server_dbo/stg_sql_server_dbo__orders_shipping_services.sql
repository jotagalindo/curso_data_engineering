WITH base AS (
    SELECT DISTINCT
        {{ dbt_utils.generate_surrogate_key(['shipping_service']) }} AS shipping_id,
        INITCAP(REGEXP_REPLACE(shipping_service, '[^a-zA-Z0-9]+', ' ')) AS shipping_description
    FROM {{ ref('base_sql_server_dbo__orders') }}
)

SELECT
  *
FROM base