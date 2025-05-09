WITH base AS (
    SELECT
        event_id,
        event_type,
        order_id,
        product_id
    FROM {{ ref('base_sql_server_dbo__events') }}
)

SELECT
    event_id,
    {{ dbt_utils.generate_surrogate_key(["COALESCE(order_id, product_id)"]) }} AS entity_id,
    CASE
        WHEN order_id IS NOT NULL AND TRIM(order_id) != '' THEN 'order'
        WHEN product_id IS NOT NULL AND TRIM(product_id) != '' THEN 'product'
        ELSE 'unknown'
    END AS event_entity_type,
    event_type
FROM base
