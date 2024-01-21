defmodule VendingMachine1.Repo.Migrations.AddOwnerFieldToProductTable do
  use Ecto.Migration

  def change do
    alter table(:products) do
      add :owner, :string, default: 
    end
  end
end
