with verbruik_per_uur as
(
    select 
        datum,
        uur,
        sum(verwacht_verbruik) as verwacht,
        sum(werkelijk_verbruik) as werkelijk    
    from {{ ref('stg_entso_verbruik')}} 
    group by datum, uur
),

final as 
(
    select
        verbruik_per_uur.datum,
        verbruik_per_uur.uur,
        verbruik_per_uur.verwacht,
        verbruik_per_uur.werkelijk,
        prijs_verbruik.prijs,
        {{ bereken_absoluut_verschil_verbruik('verbruik_per_uur.verwacht', 'verbruik_per_uur.werkelijk') }} as absoluut_verschil_verwachting
    from verbruik_per_uur
    left join {{ ref('stg_epex_prijs_verbruik')}}  as prijs_verbruik
    on verbruik_per_uur.datum = prijs_verbruik.datum
    and verbruik_per_uur.uur = prijs_verbruik.uur
)

select * from final
where absoluut_verschil_verwachting is not null
