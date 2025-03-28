{% docs bereken_omzet %}
Deze macro berekent de **omzet** op basis van de "hoeveelheid" die is verkocht en de bijbehorende prijs.
Bijvoorbeeld de omzet van energieverbruik

De berekening is eenvoudig:  
**omzet = hoeveelheid × prijs**

Indien één van de inputwaarden `null` is, retourneert de macro ook `null` om foutieve berekeningen te voorkomen.
{% enddocs %}