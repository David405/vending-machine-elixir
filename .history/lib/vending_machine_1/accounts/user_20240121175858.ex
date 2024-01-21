defmodule VendingMachine1.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password, :string
    field :role, :string, default: "buyer"
    field :deposit, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  @roles ~w(seller buyer)a
  @valid_deposit_values [5, 10, 20, 50, 100]
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :password, :deposit, :role])
    |> validate_required([:username, :password, :deposit, :role])
  end
end
