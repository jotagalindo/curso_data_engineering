WITH base AS (
    SELECT 
        order_id,
        created_at,
        order_cost,
        order_total
    FROM {{ ref('base_sql_server_dbo__orders') }}
)

SELECT
  *
FROM base