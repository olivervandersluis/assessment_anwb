# ANWB Energie: Assessment Analytics Engineer

Welkom bij het dbt-project voor het assessment van ANWB Energie.  
In dit project worden voorspelde en werkelijke stroomverbruiksdata gecombineerd met elektriciteitsprijzen om inzicht te krijgen in afwijkingen in het verbruik en de bijbehorende financiële impact.

---

## De opdracht

> Create a dbt project in dbt-core that combines both data sources and find the 10 days  
> with the biggest differences between the actual and predicted load and the (correct)  
> difference in price for that day (using the actual price on the day).

> Bekijk het oorspronkelijke in **/assets/Assessment Analytics Engineer.pdf**
---

## Uitwerking

- De opdracht is uitgevoerd met behulp van een **Snowflake-database**
- De brondata is ingeladen in Snowflake stages en via `COPY INTO` beschikbaar gemaakt voor verwerking met dbt
- DBT heeft toegang tot deze ruwe data via source-definities in de YAML-bestanden in de source folder.
- De gegevens zijn vervolgens opgeschoond, gecombineerd en geaggregeerd via `staging`, `integration`, en `marts` lagen
- De **logica** (zoals verschilberekening en omzet) is geïmplementeerd als **dbt macro’s**, zodat de businesslogica expliciet en herbruikbaar is

---

## Resultaat

Het eindresultaat is beschikbaar in het model:

**`marts.top10_dagen_verbruik_verschil`**

Dit model toont:
- De top 10 dagen met de grootste afwijkingen tussen verwacht en werkelijk verbruik
- De richting van het verschil (verbruik is hoger of lager dan verwacht)
- De verwachte en werkelijke omzet (op basis van EPEX-prijzen)
- Het financiële verschil van de afwijking

---

## Extra info
- De bronbestanden bevatten velden met lege waarden of "-" voor sommige dagen. Deze zijn opgeschoond naar `null`.
- Alleen records met complete data (zonder nulls) zijn meegenomen
- Tests zijn gedefinieerd op de `integration` en `marts` modellen
- De documentatie is volledig gegenereerd via `dbt docs`

## Datumdimensie
Voor dit project is een datumdimensie toegevoegd (`marts.dim_datum`).  
Deze bevat één rij per dag tussen 2021-01-01 en 2025-12-31, inclusief:

- ISO-weeknummer
- Dag van de week (nummer en naam)
- Werkdag/weekend-indicator
- Kwartaal

Deze dimensie kan worden gebruikt om gegevens van de dag toe te voegen bijvoorbeeld aan `top10_dagen_verbruik_verschil`.
Misschien springen er dagen uit dat de verwachting sterk afwijkt van het werkelijke verbruik.
De join is niet vastgelegd in het model zelf, deze kan via een query of rapportage tool worden gelegd via de *datum* kolom.
Wel is er een referentie test vanuit `top10_dagen_verbruik_verschil` naar `dim_datum`
