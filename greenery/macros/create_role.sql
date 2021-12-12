{% macro create_role(role) %}

{% set sql %}
    DO $$                  
    BEGIN 
        CREATE ROLE {{ role }};
    EXCEPTION
        WHEN duplicate_object THEN null;
    END
    $$ ;
{% endset %}

{% set table = run_query(sql) %}

{% endmacro %}