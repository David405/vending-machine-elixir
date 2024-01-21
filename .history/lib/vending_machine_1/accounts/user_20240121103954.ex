defmodule VendingMachine1.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :username, :string
    field :password, :string
    field :role, :string
    field :userId, :integer
    field :deposit, :integer, default: 0

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:userId, :username, :password, :role])
    |> validate_required([:userId, :username, :password, :deposit, :role])
  end
end
