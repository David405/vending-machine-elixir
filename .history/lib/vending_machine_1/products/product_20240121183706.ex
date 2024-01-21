defmodule VendingMachine1.Products.Product do
  use Ecto.Schema
  import Ecto.Changeset

  schema "products" do
    field :amount_available, :integer
    field :cost, :integer
    field :product_name, :string
    field :seller_id, :id
    field :owner, :string, default: "none"

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(product, attrs) do
    product
    |> cast(attrs, [:amount_available, :cost, :product_name, :owner])
    |> validate_required([:amount_available, :cost, :product_name])
  end

  def change_owner(product, username) do
    user
    |> Ecto.Changeset.change(deposit: user.deposit - amount)
    |> Ecto.Changeset.apply_changes()
  end
end
