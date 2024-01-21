defmodule VendingMachine1.ProductsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `VendingMachine1.Products` context.
  """

  @doc """
  Generate a product.
  """
  def product_fixture(attrs \\ %{}) do
    {:ok, product} =
      attrs
      |> Enum.into(%{
        amount_available: 42,
        cost: 42,
        product_name: "some product_name"
      })
      |> VendingMachine1.Products.create_product()

    product
  end
end
