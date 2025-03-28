with basis as 
(
    select 
        datum,
        sum(verwacht) as verwacht_verbruik,
        sum(werkelijk) as werkelijk_verbruik,
        sum(absoluut_verschil_verwachting) as absoluut_verschil_verwachting,        
        sum({{ bereken_omzet('verwacht', 'prijs') }}) as verwachte_omzet, 
        sum({{ bereken_omzet('werkelijk', 'prijs') }}) as werkelijke_omzet,
        sum({{ bereken_omzet('absoluut_verschil_verwachting', 'prijs') }}) as verschil_omzet
    from {{ ref('int_verbruik_per_dag' ) }}
    group by datum
),

final as 
(
    select 
        datum,
        {{ bereken_richting_verwachtingsverschil('verwacht_verbruik', 'werkelijk_verbruik') }} as type_verschil, 
        {{ bereken_procentueel_verschil('verwacht_verbruik', 'werkelijk_verbruik') }}  as procentuele_afwijking_van_verwacht_verbruik,
        absoluut_verschil_verwachting,
        verwachte_omzet,
        werkelijke_omzet,
        verschil_omzet
    from basis
    order by absoluut_verschil_verwachting desc
    limit 10
)
select * from final
