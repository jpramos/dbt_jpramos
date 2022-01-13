
{% set funnel_levels = {
    'level_1': ('page_view','add_to_cart','checkout'),
    'level_2': ('add_to_cart','checkout'),
    'level_3': ('checkout',),
    } %}

with agg_sessions as(
        select
            count(distinct session_uuid)::decimal as total_sessions,
            {% for (lvl_name, lvl_fields) in funnel_levels.items() %}
                {% if lvl_fields|length > 1 %}
                    count(distinct case when event_type in {{ lvl_fields }} then session_uuid end ) as funnel_{{ lvl_name }}
                {% else %}
                    count(distinct case when event_type = '{{ lvl_fields[0] }}' then session_uuid end ) as funnel_{{ lvl_name }}
                {% endif %}
                {% if not loop.last %}, {% endif %}
            {% endfor %}
        from  
            {{ ref('stg_events') }}
)
select * from agg_sessions