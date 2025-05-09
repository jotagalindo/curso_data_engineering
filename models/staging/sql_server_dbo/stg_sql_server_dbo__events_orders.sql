WITH base AS (
    SELECT
        event_id,
        event_type_id,
        {{ dbt_utils.generate_surrogate_key(['order_id']) }} AS order_id
    FROM {{ ref('base_sql_server_dbo__events') }}
),

event_type AS (
    SELECT
        event_type_id
    FROM {{ ref('stg_sql_server_dbo__event_type') }}
)

SELECT
    b.event_id,
    b.order_id,
    b.event_type_id
FROM base b
LEFT JOIN event_type e ON b.event_type_id = e.event_type_id
