defmodule VendingMachine1.AccountsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VendingMachine1.Accounts` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        deposit: 42,
        password: "some password",
        role: "some role",
        userId: 42,
        username: "some username"
      })
      |> VendingMachine1.Accounts.create_user()

    user
  end
end
