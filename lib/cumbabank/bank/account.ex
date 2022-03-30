defmodule Cumbabank.Bank.Account do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query

  alias Cumbabank.Bank.Account
  alias Cumbabank.Bank.User
  alias Cumbabank.Repo

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "accounts" do
    field :current_balance, :decimal
    field :initial_balance, :decimal

    timestamps()

  end

  @doc false
  def changeset(account, attrs) do
    account
    |> cast(attrs, [:initial_balance, :current_balance])
    |> validate_required([:initial_balance, :current_balance])
  end

  def get_account_by_user_id(id) do
    query = from(c in Account,
      inner_join: u in User,
      on: c.id == u.account_id,
      where: u.id == ^id,
      select: c)

    Repo.one(query)
  end
end
