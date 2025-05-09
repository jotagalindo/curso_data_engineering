{{ config(materialized='table') }}

WITH seconds AS (
    SELECT 
        SEQ4() AS second_of_day
    FROM TABLE(GENERATOR(ROWCOUNT => 86400))  -- 24*60*60 = 86400 segundos
),

time_dim AS (
    SELECT
        FLOOR(second_of_day / 3600) AS hour,
        FLOOR(MOD(second_of_day, 3600) / 60) AS minute,
        MOD(second_of_day, 60) AS second
    FROM seconds
),

final AS (
    SELECT
        TO_TIME(
            LPAD(hour::STRING, 2, '0') || ':' ||
            LPAD(minute::STRING, 2, '0') || ':' ||
            LPAD(second::STRING, 2, '0')
        ) AS time,
        hour,
        minute,
        second,
        LPAD(hour::STRING, 2, '0') || ':' || LPAD(minute::STRING, 2, '0') AS hour_minute,
        LPAD(hour::STRING, 2, '0') || ':' || LPAD(minute::STRING, 2, '0') || ':' || LPAD(second::STRING, 2, '0') AS time_formatted
    FROM time_dim
)

SELECT * FROM final
