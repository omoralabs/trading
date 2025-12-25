from alpaca.trading.client import TradingClient
from alpaca.trading.enums import QueryOrderStatus
from alpaca.trading.requests import GetOrdersRequest


def get_open_orders(ctx: TradingClient):
    params = GetOrdersRequest(status=QueryOrderStatus.OPEN)
    return ctx.get_orders(filter=params)


def get_open_positions(ctx: TradingClient):
    return ctx.get_all_positions()
