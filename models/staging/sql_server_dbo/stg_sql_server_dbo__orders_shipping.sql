WITH base AS (
    SELECT 
        order_id,
        shipping_cost,
        {{ dbt_utils.generate_surrogate_key(['shipping_service']) }} AS shipping_id,
        address_id,
        estimated_delivery_at,
        delivered_at,
        tracking_id,
        {{ dbt_utils.generate_surrogate_key(['status']) }} as status_id,
    FROM {{ ref('base_sql_server_dbo__orders') }}
)

SELECT
  *
FROM base