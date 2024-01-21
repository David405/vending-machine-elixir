defmodule VendingMachine1.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :userId, :serial, primary_key: true
      add :username, :string
      add :password, :string
      add :deposit, :integer
      add :role, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users)
  end
end
