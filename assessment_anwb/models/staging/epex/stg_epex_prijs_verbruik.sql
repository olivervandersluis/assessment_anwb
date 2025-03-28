select 
    price_date as datum,
    price_hour as uur,
    product_type as product_type,
    try_cast(price as numeric(3,2)) as prijs
from {{ source('epex', 'average_electricity_prices') }}
