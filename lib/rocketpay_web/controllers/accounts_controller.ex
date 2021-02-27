defmodule RocketpayWeb.AccountsController do
  use RocketpayWeb, :controller

  alias Rocketpay.Account
  alias Rocketpay.Accounts.Transaction.Response, as: TransactionResponse

  action_fallback RocketpayWeb.FallbackController

  def deposit(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.account_deposit(params) do
      conn
      |> put_status(:ok)
      |> put_view(RocketpayWeb.AccountsView)
      |> render("deposit.json", account: account)
    end
  end

  def withdraw(conn, params) do
    with {:ok, %Account{} = account} <- Rocketpay.account_withdraw(params) do
      conn
      |> put_status(:ok)
      |> put_view(RocketpayWeb.AccountsView)
      |> render("withdraw.json", account: account)
    end
  end

  def transaction(conn, params) do
    with {:ok, %TransactionResponse{} = transaction} <- Rocketpay.transaction(params) do
      conn
      |> put_status(:ok)
      |> put_view(RocketpayWeb.AccountsView)
      |> render("transaction.json", transaction: transaction)
    end
  end
end
