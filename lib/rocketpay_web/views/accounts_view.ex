defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.Account

  def render("deposit.json", %{account: %Account{id: id, balance: balance}}) do
    %{
      message: "Deposit successful",
      account: %{
        id: id,
        balance: balance,
      }
    }
  end

  def render("withdraw.json", %{account: %Account{id: id, balance: balance}}) do
    %{
      message: "Withdraw successful",
      account: %{
        id: id,
        balance: balance,
      }
    }
  end
end
