
with unpivoted as (
    {{ dbt_utils.unpivot(ref('product_funnel'), cast_to='decimal') }}
)
select 
    *,
    {% for n_level in range(1, 4) %}
        round(100 * (lead(value, {{ n_level }}) OVER (ORDER BY value desc) - value) / value, 2) as pct_change_2lvl_{{ n_level }}
        {% if not loop.last %}, {% endif %}
    {% endfor %}
from unpivoted