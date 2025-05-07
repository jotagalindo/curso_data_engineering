SELECT
    {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id,
    INITCAP(REGEXP_REPLACE(promo_id, '[^a-zA-Z0-9]+', ' ')) as promo_description,
    discount,
    {{ dbt_utils.generate_surrogate_key(['status']) }} as status_id,
    status as status_description,
    {{ add_fivetran_metadata() }}
FROM {{ source('sql_server_dbo', 'promos') }}
-- WHERE _fivetran_deleted IS NULL