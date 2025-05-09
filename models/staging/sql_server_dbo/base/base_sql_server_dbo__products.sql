SELECT
    {{ dbt_utils.generate_surrogate_key(['order_id']) }} as order_id,
    shipping_service,
    shipping_cost,
    {{ dbt_utils.generate_surrogate_key(['address_id']) }} as address_id,
    CONVERT_TIMEZONE('UTC', created_at) as created_at,
    promo_id,
    CONVERT_TIMEZONE('UTC', estimated_delivery_at) as estimated_delivery_at,
    order_cost,
    {{ dbt_utils.generate_surrogate_key(['order_id']) }} as user_id,
    order_total,
    CONVERT_TIMEZONE('UTC', delivered_at) as delivered_at,
    {{ dbt_utils.generate_surrogate_key(['tracking_id']) }} as tracking_id,
    status,
    {{ add_fivetran_metadata() }}
FROM {{ source('sql_server_dbo', 'orders') }}
