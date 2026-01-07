{{ config(materialized='view') }}

with trade_executions as(
    select * from {{ ref ('trade_executions') }}
)

select
    trade_id,
    sum(abs(filled_qty)) as total_qty,
    min(filled_at) as date_opened,
    max(filled_at) as date_closed
from trade_executions
group by trade_id
