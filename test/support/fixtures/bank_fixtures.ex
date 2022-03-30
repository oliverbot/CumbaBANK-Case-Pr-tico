defmodule Cumbabank.BankFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Cumbabank.Bank` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        returned: true
      })
      |> Cumbabank.Bank.create_transaction()

    transaction
  end

  @doc """
  Generate a account.
  """
  def account_fixture(attrs \\ %{}) do
    {:ok, account} =
      attrs
      |> Enum.into(%{
        current_balance: "120.5",
        initial_balance: "120.5"
      })
      |> Cumbabank.Bank.create_account()

    account
  end

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        cpf: "some cpf",
        email: "some email",
        name: "some name",
        password: "some password"
      })
      |> Cumbabank.Bank.create_user()

    user
  end
end
