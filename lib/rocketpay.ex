defmodule Rocketpay do
  alias Rocketpay.Users.Create, as: UserCreate
  alias Rocketpay.Accounts.Deposit, as: AccountDeposit
  alias Rocketpay.Accounts.Withdraw, as: AccountWithdraw
  alias Rocketpay.Accounts.Transaction, as: Transaction

  defdelegate create_user(params), to: UserCreate, as: :call
  defdelegate account_deposit(params), to: AccountDeposit, as: :call
  defdelegate account_withdraw(params), to: AccountWithdraw, as: :call
  defdelegate transaction(params), to: Transaction, as: :call
end
