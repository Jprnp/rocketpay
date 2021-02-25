defmodule Rocketpay.Accounts.Deposit do
  alias Ecto.Multi
  alias Rocketpay.{Repo, Account}

  def call(%{"account_id" => id, "amount" => amount}) do
    Multi.new()
    |> Multi.run(:account, fn repo, _changes ->  get_account(repo, id) end)
    |> Multi.run(:update_balance, fn repo, %{account: account} ->  update_balance(repo, account, amount) end)
    |> run_transaction()
  end

  defp get_account(repo, id) do
    case repo.get(Account, id) do
      nil -> {:error, "Account not found"}
      account -> {:ok, account}
    end
  end

  defp update_balance(repo, account, amount) do
    account
    |> sum_values(amount)
    |> update_account(repo, account)
  end

  defp sum_values(%Account{balance: balance}, amount) do
    amount
    |> Decimal.cast()
    |> handle_cast(balance)
  end

  defp handle_cast({:ok, amount}, balance), do: Decimal.add(amount, balance)
  defp handle_cast({:error, _balance}), do: {:error, "Invalid deposit amount"}

  defp update_account({:error, _reason} = error, _repo, _account), do: error
  defp update_account(balance, repo, account) do
    params = %{balance: balance}

    account
    |> Account.changeset(params)
    |> repo.update()
  end

  defp run_transaction(multi) do
    case Repo.transaction(multi) do
      {:error, _operation, reason, _changes} -> {:error, reason}
      {:ok, %{update_balance: account}} -> {:ok, account}
    end
  end
end
