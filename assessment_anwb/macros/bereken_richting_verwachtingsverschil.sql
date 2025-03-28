{% macro bereken_richting_verwachtingsverschil(verwacht, werkelijk) %}
    case
        when {{ verwacht }} is null or {{ werkelijk }} is null then 'onbekend'
        when {{ verwacht }} > {{ werkelijk }} then 'minder dan verwacht' 
        when {{ verwacht }} < {{ werkelijk }} then 'meer dan verwacht'                   
        when {{ verwacht }} = {{ werkelijk }} then 'spot on' 
        else 'onbekend'
    end
{% endmacro %}

