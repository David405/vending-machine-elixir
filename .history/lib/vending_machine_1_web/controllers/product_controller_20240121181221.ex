defmodule VendingMachine1Web.ProductController do
  use VendingMachine1Web, :controller

  alias VendingMachine1.Products
  alias VendingMachine1.Products.Product

  alias VendingMachine1.Accounts
  alias VendingMachine1.Accounts.User

  def index(conn, _params) do
    products = Products.list_products()
    render(conn, :index, products: products)
  end

  def new(conn, _params) do
    changeset = Products.change_product(%Product{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"product" => product_params}) do
    case Products.create_product(product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product created successfully.")
        |> redirect(to: ~p"/products/#{product}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    render(conn, :show, product: product)
  end

  def edit(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    changeset = Products.change_product(product)
    render(conn, :edit, product: product, changeset: changeset)
  end

  def update(conn, %{"id" => id, "product" => product_params}) do
    product = Products.get_product!(id)

    case Products.update_product(product, product_params) do
      {:ok, product} ->
        conn
        |> put_flash(:info, "Product updated successfully.")
        |> redirect(to: ~p"/products/#{product}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, product: product, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    product = Products.get_product!(id)
    {:ok, _product} = Products.delete_product(product)

    conn
    |> put_flash(:info, "Product deleted successfully.")
    |> redirect(to: ~p"/products")
  end

  def buy(conn, %{"id" => id, productId" => product_id, "amount" => amount}) do
    user = Accounts.get_user!(id)

    case can_user_buy?(user) do
      true ->
        case buy_products(user, product_id, amount) do
          {:ok, total_spent, purchased_products, change_coins} ->
            conn
            |> put_status(:ok)
            |> json(%{
              total_spent: total_spent,
              purchased_products: purchased_products,
              change_coins: change_coins
            })
          {:error, reason} ->
            conn
            |> put_status(:unprocessable_entity)
            |> json(%{error: reason})
        end
      false ->
        conn
        |> put_status(:forbidden)
        |> json(%{error: "User does not have the buyer role"})
    end
  end
end
