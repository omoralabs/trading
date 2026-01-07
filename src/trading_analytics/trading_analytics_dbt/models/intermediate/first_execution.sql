{{ config(materialized='view') }}

with trade_executions as(
    select * from {{ ref ('trade_executions') }}
)

select *
from trade_executions
where execution_order = 1
