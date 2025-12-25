import os
from dataclasses import dataclass

from alpaca.trading.client import TradingClient
from alpaca.trading.stream import TradingStream
from dotenv import load_dotenv
from prompt_toolkit.shortcuts import radiolist_dialog


@dataclass
class TradingContext:
    client: TradingClient
    risk_pct: float
    is_paper: bool
    account_value: float
    risk_reward: float


async def update_handler(data):
    # trade updates will arrive in our async handler
    trading_stream = TradingStream(api_key, secret_key, paper=is_paper)
    trading_stream.subscribe_trade_updates(update_handler)
    trading_stream.run()
    print(data)


if __name__ == "__main__":
    load_dotenv()

    is_paper = radiolist_dialog(
        title="Trading Mode",
        text="Select trading mode:",
        values=[(True, "Paper"), (False, "Live")],
    ).run()

    api_key = (
        os.environ["ALPACA_API_KEY_PAPER"]
        if is_paper
        else os.environ["ALPACA_API_KEY_LIVE"]
    )
    secret_key = (
        os.environ["ALPACA_SECRET_KEY_PAPER"]
        if is_paper
        else os.environ["ALPACA_SECRET_KEY_LIVE"]
    )

    client = TradingClient(api_key, secret_key, paper=is_paper, raw_data=False)

    ctx = TradingContext(
        client=client,
        risk_pct=0.025,
        is_paper=is_paper,
        account_value=float(client.get_account().last_equity or 0),
        risk_reward=5,
    )
