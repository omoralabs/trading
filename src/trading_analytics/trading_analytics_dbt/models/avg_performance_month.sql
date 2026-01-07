{{config (materialised='view')}}

with weekly_performance as (
    select * from {{ref('monthly_performance')}}
)

select
    extract(year from month) as year,
    avg(total_return_pct),
    avg(nr_of_trades)
from monthly_performance
group by extract(year from month)
