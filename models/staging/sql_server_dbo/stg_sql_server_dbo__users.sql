SELECT
    {{ dbt_utils.generate_surrogate_key(['user_id']) }} as user_id,
    first_name,
    last_name,
    email,
    phone_number,
    {{ dbt_utils.generate_surrogate_key(['address_id']) }} as address_id,
    CONVERT_TIMEZONE('UTC', created_at) as created_at,
    CONVERT_TIMEZONE('UTC', updated_at) as updated_at,
    {{ add_fivetran_metadata() }},

    -- Validación del teléfono: formato 999-999-9999
    REGEXP_LIKE(phone_number, '^\\d{3}-\\d{3}-\\d{4}$') AS valid_phone,

    -- Validación del email
    REGEXP_LIKE(email, '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$') AS valid_email

FROM {{ source('sql_server_dbo', 'users') }}