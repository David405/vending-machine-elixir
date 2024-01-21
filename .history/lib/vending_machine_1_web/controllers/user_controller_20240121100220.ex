defmodule VendingMachine1Web.UserController do
  use VendingMachine1Web, :controller

  alias VendingMachine1.Accounts
  alias VendingMachine1.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, :index, users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: ~p"/users/#{user}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, :show, user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, :edit, user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: ~p"/users/#{user}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: ~p"/users")
  end

  def deposit(conn, %{"amount" => amount_str}) do
    amount = String.to_integer(amount_str)

    validate_amount(amount)
    current_user = conn.assigns[:current_user] 

    # Update the user's deposit field in the database
    {:ok, _user} = YourApp.Accounts.deposit(current_user, amount)

    conn
    |> put_flash(:info, "Deposit successful")
    # |> redirect(to: page_path(conn, :index))
  end

  defp validate_amount(amount) do
    if rem(amount, 5) != 0 do
      raise Phoenix.Controller.InvalidParams, "Amount must be a multiple of 5"
    end
  end
end
