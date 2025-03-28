{% macro bereken_absoluut_verschil_verbruik(verwacht, werkelijk) %}
    case
        when {{ verwacht }} is null or {{ werkelijk }} is null then null
        else abs({{ verwacht }} - {{ werkelijk }})
    end
{% endmacro %}

