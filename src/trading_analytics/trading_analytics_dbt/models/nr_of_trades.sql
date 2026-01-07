{{config (materialised='view')}}

with trades_view as (
    select * from {{ref('trades_view')}}
)


select
    sum(
        case
            when risk_reward > 0 then 1 else 0 end
    )
from trades_view
