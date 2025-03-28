{% macro bereken_procentueel_verschil(begin_waarde, eind_waarde, precisie=1) %}
    case
        when {{ begin_waarde }} = 0 then null
        else round((({{ eind_waarde }} - {{ begin_waarde }}) / {{ begin_waarde }}) * 100, {{ precisie }})
    end
{% endmacro %}
