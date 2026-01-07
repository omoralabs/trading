{{ config (materialized='view') }}

with trades as (
    select * from {{source('stocksdb', 'trades')}}
),

executions as (
    select * from {{source('stocksdb', 'executions')}}
)


select
    t.trade_id,
    e.execution_id,
    e.symbol,
    e.side,
    e.position_intent,
    e.filled_at,
    e.filled_qty,
    e.filled_avg_price,
    e.account_id,
    row_number() over (partition by t.trade_id order by e.id) as execution_order,
    row_number() over (partition by t.trade_id order by e.id desc) as execution_order_desc
from trades t
join executions e on t.id = e.id
