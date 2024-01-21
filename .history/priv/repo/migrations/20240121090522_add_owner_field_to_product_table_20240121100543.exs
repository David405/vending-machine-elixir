defmodule VendingMachine1.Repo.Migrations.AddOwnerFieldToProductTable do
  use Ecto.Migration

  def change do
    alter table(:your_table) do
      add :new_field, :integer, default: 0
    end
  end
end
