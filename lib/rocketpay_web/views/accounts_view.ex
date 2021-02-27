defmodule RocketpayWeb.AccountsView do
  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transaction.Response, as: TransactionResponse

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

  def render("transaction.json", %{transaction: %TransactionResponse{from_account: from_account, to_account: to_account}}) do
    %{
      message: "Transaction successful",
      transaction: %{
        from_account: %{
          id: from_account.id,
          balance: from_account.balance,
        },
        to_account: %{
          id: to_account.id,
          balance: to_account.balance,
        }
      }
    }
  end
end
