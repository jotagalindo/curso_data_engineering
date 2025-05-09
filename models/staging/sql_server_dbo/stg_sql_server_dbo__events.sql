WITH base AS (
    SELECT
    event_id,
    page_url,
    user_id,
    {{ dbt_utils.generate_surrogate_key(['session_id']) }} as session_id,
    CONVERT_TIMEZONE('UTC', created_at) as created_at,
    is_deleted,
    date_load
    FROM {{ ref('base_sql_server_dbo__events') }}
    ORDER BY created_at
)

SELECT
  *
FROM base