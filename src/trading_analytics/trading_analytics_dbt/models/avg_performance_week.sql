{{config (materialised='view')}}

with weekly_performance as (
    select * from {{ref('weekly_performance')}}
)

select
    extract(year from week) as year,
    avg(total_return_pct),
    avg(nr_of_trades)
from weekly_performance
group by extract(year from week)
