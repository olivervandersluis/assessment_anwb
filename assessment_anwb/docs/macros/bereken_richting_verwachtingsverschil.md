{% docs bereken_richting_verwachtingsverschil %}
Deze macro bepaalt de **richting van het verschil tussen het verwachte en het werkelijke verbruik**.

De uitkomst is een tekstuele classificatie die aangeeft of het werkelijke verbruik:
    - **hoger was dan verwacht** -> `"meer dan verwacht"`
    - **lager was dan verwacht** -> `"minder dan verwacht"`
    - **gelijk was aan de verwachting** -> `"spot on"`
    - **of onbekend, indien één van de waarden `null` is** -> `"onbekend"`
{% enddocs %}