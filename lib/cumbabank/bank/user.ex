defmodule Cumbabank.Bank.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Cumbabank.Bank.ChangesetHelper

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "users" do
    field :cpf, :string
    field :email, :string
    field :name, :string
    field(:password, :string, virtual: true)
    field :password_hash, :string
    field :account_id, :binary_id

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :cpf, :email, :password, :account_id])
    |> validate_required([:name, :cpf, :email])
    |> apply_default_rules()
  end

  defp apply_default_rules(changeset) do
    changeset
    |> ChangesetHelper.validate_email()
    |> ChangesetHelper.validate_password()
    |> ChangesetHelper.put_pass_hash()
  end
end
