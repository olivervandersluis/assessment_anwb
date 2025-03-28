with basis as 
(
    select 
    --bestaande periode opknippen in een begin en een eind tijd
    trim(split(time_cet, '-')[0]) as str_periode_start, 
    trim(split(time_cet, '-')[1]) as str_periode_end ,
    try_cast(day_ahead_total_load_forecast_mw_bzn_nl as int) as verwacht_verbruik,
    try_cast(actual_total_load_mw_bzn_nl as int) as werkelijk_verbruik

    from {{ source('entso','totalload_dayahaed_actual')}}
),

periodes as 
(
    select 
        --omzetten van de periodes in datumtijd waarden
        to_timestamp(str_periode_start, 'DD.MM.YYYY HH:MI') as periode_start_cet,
        to_timestamp(str_periode_end, 'DD.MM.YYYY HH:MI') as periode_end_cet,    
        *
    from basis
)

select 
    periode_start_cet,
    periode_end_cet,
    periode_start_cet::date as datum, 
    extract(hour from periode_start_cet)as uur,
    verwacht_verbruik,
    werkelijk_verbruik
from periodes