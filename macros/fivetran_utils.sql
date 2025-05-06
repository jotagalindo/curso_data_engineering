{% macro add_fivetran_metadata(deleted_col='_fivetran_deleted', synced_col='_fivetran_synced') %}
    CASE
        WHEN {{ deleted_col }} = true THEN {{ deleted_col }}
        ELSE false
    END AS is_deleted,
    CONVERT_TIMEZONE('UTC', {{ synced_col }}) AS date_load
{% endmacro %}
