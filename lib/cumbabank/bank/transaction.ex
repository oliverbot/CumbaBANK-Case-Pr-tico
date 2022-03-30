defmodule Cumbabank.Bank.Transaction do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false

  alias Cumbabank.Bank.Transaction
  alias Cumbabank.Bank.Account
  alias Cumbabank.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "transactions" do
    field :amount, :decimal
    field :returned, :boolean, default: false
    field :from_account, :binary_id
    field :to_account, :binary_id

    timestamps()
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :from_account, :to_account])
    |> validate_required([:amount, :from_account, :to_account])
  end

  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  def create_account_transaction(transaction_params) do

    Repo.transaction(fn ->
      with {:ok, __struct__} <- transaction_operation_extract(transaction_params),
           {:ok, __struct__} <- transaction_operation_receive(transaction_params),
           {:ok, %Transaction{} = transaction} <- create_transaction(transaction_params)
           do
            transaction
           else
            {:error, error} ->
              IO.inspect(error, label: "Error")
              Repo.rollback(error)
           end
    end)
  end

  def transaction_operation_receive(transaction) do
    account =
      Account
      |> lock("FOR UPDATE")
      |> Repo.get!(transaction["to_account"])

    {:ok, decimal} = Decimal.cast(transaction["amount"])

    account
    |> Account.changeset(%{current_balance: Decimal.add(account.current_balance, decimal)})
    |> Repo.update()
  end

  def transaction_operation_extract(transaction) do
    account =
      Account
      |> lock("FOR UPDATE")
      |> Repo.get!(transaction["from_account"])

    {:ok, decimal} = Decimal.cast(transaction["amount"])

    if account.current_balance >= decimal do
      account
      |> Account.changeset(%{current_balance: Decimal.sub(account.current_balance, decimal)})
      |> Repo.update()
    else
      {:error, "Saldo insuficiente"}
    end

  end

  def get_transactions_by_period(start, finish) do
    initial_date = NaiveDateTime.from_iso8601!(start <> " 00:00:00")
    end_date = NaiveDateTime.from_iso8601!(finish <> " 23:59:59")
    query =
      from(
        t in Transaction,
        where: t.inserted_at >= ^initial_date,
        where: t.inserted_at <= ^end_date
      )

    Repo.all(query)
  end
end
