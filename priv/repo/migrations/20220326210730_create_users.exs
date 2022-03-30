defmodule Cumbabank.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :cpf, :string
      add :email, :string
      add :password_hash, :string
      add :enabled, :boolean
      add :account_id, references(:accounts, type: :binary_id)

      timestamps()
    end
    create(unique_index(:users, [:cpf]))
    create(unique_index(:users, [:email]))
  end
end
