{% macro count_events(event_types) %}

    {% for et in event_types %}
    
    sum(number_of_{{ et }}) as number_of_{{ et }}
    
    {% if not loop.last %} , {% endif %}
    {% endfor %}

{% endmacro %}