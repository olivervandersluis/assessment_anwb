{% macro bereken_omzet(hoeveelheid, prijs) %}
    case
        when {{ hoeveelheid }} is null or {{ prijs }} is null then null
        else {{ hoeveelheid }} * {{ prijs }}
    end
{% endmacro %}