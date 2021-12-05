{% macro apply_grants_select_usage(role) %}

{% set sql %}
    GRANT SELECT ON ALL TABLES IN SCHEMA {{ schema }} TO {{ role }};
    GRANT USAGE ON SCHEMA {{ schema }} TO {{ role }};
{% endset %}

{% set table = run_query(sql) %}

{% endmacro %}