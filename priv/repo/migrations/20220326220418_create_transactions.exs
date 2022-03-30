defmodule Cumbabank.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :amount, :decimal
      add :from_account, references(:accounts, type: :binary_id)
      add :to_account, references(:accounts, type: :binary_id)
      add :returned, :boolean, default: false, null: false

      timestamps()
    end
  end
end
