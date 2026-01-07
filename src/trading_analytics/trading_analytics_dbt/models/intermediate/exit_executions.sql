{{ config(materialized='view') }}

with trade_executions as(
    select * from {{ ref ('trade_executions') }}
)

select
    trade_id,
    sum(filled_qty * filled_avg_price) / sum(filled_qty) as avg_exit_price
from trade_executions
where position_intent in('buy_to_close', 'sell_to_close')
group by trade_id
