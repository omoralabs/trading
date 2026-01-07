{{config (materialised='view')}}

with trades_view as (
    select * from {{ref('trades_view')}}
),

trade_count as (
    select * from {{ref('trade_count')}}
)

select
    tc.date_opened as day,
    tc.nr_of_trades as nr_of_trades,
    (tc.winning_trades / tc.nr_of_trades):: float as accuracy,
    avg(tv.risk_per_trade) as avg_risk_per_trade,
    avg(case when tv.risk_reward > 0 then tv.risk_reward end) as avg_win,
    avg(case when tv.risk_reward < 0 then tv.risk_reward end) as avg_loss,
    avg(return_pct) as avg_return_pct,
    sum(return_pct) as total_return_pct
from trade_count tc
join trades_view tv on tc.date_opened = tv.date_opened
group by tc.date_opened, tc.nr_of_trades, tc.winning_trades
