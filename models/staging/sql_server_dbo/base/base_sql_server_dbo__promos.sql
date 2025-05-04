SELECT
  {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id,
  promo_id as promo_description,
  discount,
    case
    when lower(status) = 'active' then 1
    when lower(status) = 'inactive' then 0
    else null
  end as status,
  _fivetran_deleted,
  convert_timezone('UTC', _fivetran_synced) as _fivetran_synced
FROM {{ SOURCE('sql_server_dbo', 'promos') }}

