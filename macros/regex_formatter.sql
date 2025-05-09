{% macro clean_string(column_name, replacement_char='_') %}
    REGEXP_REPLACE({{ column_name }}, '[^a-zA-Z0-9]+', '{{ replacement_char }}')
{% endmacro %}
