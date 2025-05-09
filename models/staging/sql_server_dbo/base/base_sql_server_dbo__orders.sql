SELECT
    {{ dbt_utils.generate_surrogate_key(['order_id']) }} as order_id,
    CASE WHEN 
        shipping_service IS NULL OR TRIM(shipping_service) = '' THEN 'pending_shipping' 
    ELSE shipping_service END AS shipping_service,
    shipping_cost,
    {{ dbt_utils.generate_surrogate_key(['address_id']) }} as address_id,
    CONVERT_TIMEZONE('UTC', created_at) as created_at,
    CASE WHEN 
        promo_id IS NULL OR TRIM(promo_id) = '' THEN 'no_promo' 
    ELSE promo_id END AS promo_id,
    CONVERT_TIMEZONE('UTC', estimated_delivery_at) as estimated_delivery_at,
    order_cost,
    {{ dbt_utils.generate_surrogate_key(['order_id']) }} as user_id,
    order_total,
    CONVERT_TIMEZONE('UTC', delivered_at) as delivered_at,
    tracking_id,
    status,
    {{ add_fivetran_metadata() }}
FROM {{ source('sql_server_dbo', 'orders') }}