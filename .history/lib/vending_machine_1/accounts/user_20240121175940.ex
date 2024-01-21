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

  defp validate_deposit_inclusion(changeset) do
    deposit = get_field(changeset, :deposit)

    if deposit in @valid_deposit_values do
      changeset
    else
      add_error(changeset, :deposit, "must be one of: #{@valid_deposit_values}")
    end
  end
end
