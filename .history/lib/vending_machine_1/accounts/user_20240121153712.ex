defmodule VendingMachine1.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password, :string
    field :role, :string, default: "buyer"
    field :userId, :integer
    field :deposit, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  @roles ~w(seller buyer)a
  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:userId, :username, :password, :deposit, :role])
    |> validate_required([:username, :password, :deposit, :role])
    |> unique_constraint(:userId)
  end
end
