defmodule VendingMachine1.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password, :string
    field :role, :string, default: "buyer"
    add :id, :serial, primary_key: true
    field :deposit, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  @roles ~w(seller buyer)a
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:userId, :username, :password, :deposit, :role])
    |> validate_required([:userId, :username, :password, :deposit, :role])
    # |> validate_inclusion(:role, @roles)
  end
end
