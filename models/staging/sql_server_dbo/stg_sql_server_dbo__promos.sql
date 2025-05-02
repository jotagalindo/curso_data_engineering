with base as (
  select * from {{ ref('stg_sql_server_dbo__promos') }}
)

select
  {{ dbt_utils.generate_surrogate_key(['promo_id']) }} as promo_id_hashed,
  base.*
from base