WITH base AS (
    SELECT DISTINCT
    status_id,
    CASE
        WHEN lower(status_description) = 'active' THEN 'Active'
        ELSE 'Inactive'
    END AS status_description,
    FROM {{ ref('base_sql_server_dbo__promos') }}
)

SELECT
    *
FROM base