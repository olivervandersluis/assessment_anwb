with kalender as (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="'2021-01-01'",
        end_date="'2026-01-01'"
    ) }}
),

dim as (
    select 
        date_day::date as datum,
        extract(year from date_day ) as jaar,
        extract(month from date_day ) as maand,
        extract(day from date_day ) as dag,
        extract(weekiso from date_day ) as weeknummer,
        extract(dow from date_day) + 1 as dag_van_week,
        case extract(dow from date_day)
            when 0 then 'zondag'
            when 1 then 'maandag'
            when 2 then 'dinsdag'
            when 3 then 'woensdag'
            when 4 then 'donderdag'
            when 5 then 'vrijdag'
            when 6 then 'zaterdag'
        end as naam_dag_van_week,
        case when extract(dow from date_day) in (5,6) then true else false end as is_weekend,
        case when extract(dow from date_day) in (0,1,2,3,4) then true else false end as is_werkdag,
        extract(quarter from date_day) as kwartaal
    from kalender
)

select * from dim
