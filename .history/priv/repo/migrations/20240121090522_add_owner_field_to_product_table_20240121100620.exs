defmodule VendingMachine1.Repo.Migrations.AddOwnerFieldToProductTable do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :new_field, :integer, default: 0
    end
  end
end
