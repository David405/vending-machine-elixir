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

  def deposit(conn, %{"user_id" => user_id, "coins" => coins}) do
    user = VendingMachine.Repo.get(VendingMachine.User, user_id)

    case deposit_coins(user, coins) do
      {:ok, updated_user} ->
        render(conn, "show.json", user: updated_user)
      {:error, reason} ->
        conn
        |> put_status(400)
        |> render("error.json", %{error: reason})
    end
  end

  defp deposit_coins(user, coins) do
    # Validate and handle the logic for depositing coins here
    # For simplicity, we'll assume coins is a list of valid denominations
    # Update the user's deposit in the database
    updated_user = VendingMachine.User.deposit_coins(user, coins)
    {:ok, updated_user}
  rescue
    _ ->
      {:error, "Invalid deposit"}
  end
end
