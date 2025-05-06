SELECT DISTINCT
  CASE
    WHEN lower(status) = 'active' THEN {{ dbt_utils.generate_surrogate_key([1]) }}
    ELSE {{ dbt_utils.generate_surrogate_key([0]) }}
  END as status_id,
  CASE
    WHEN lower(status) = 'active' THEN 'Active'
    ELSE 'Inactive'
  END AS status_description
FROM {{ source('sql_server_dbo', 'promos') }}
