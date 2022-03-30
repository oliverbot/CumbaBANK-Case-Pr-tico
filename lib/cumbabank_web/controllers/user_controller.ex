defmodule CumbabankWeb.UserController do
  use CumbabankWeb, :controller

  alias Cumbabank.Bank
  alias Cumbabank.Bank.User
  alias Cumbabank.Bank.Account
  alias Cumbabank.Repo
  alias Cumbabank.Auth

  plug(
    Guardian.Plug.EnsureAuthenticated,
    [key: :user]
    when action not in [
      :create,
      :login,
      :create_account
    ]
  )

  action_fallback CumbabankWeb.FallbackController

  def index(conn, _params) do
    users = Bank.list_users()
    render(conn, "index.json", users: users)
  end

  def create_account(conn, %{"account" => params}) do

    initial_balance = params["initial_balance"]

    user_params = params
    account_params = %{
      current_balance: initial_balance,
      initial_balance: initial_balance
    }

    with {:ok, %{} = account} <- Bank.create_user_account(account_params, user_params) do
      conn
      |> put_status(:created)
      |> render("show_account.json", %{account: account})
    end

  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Bank.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.user_path(conn, :show, user))
      |> render("show.json", user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Bank.get_user!(id)
    render(conn, "show.json", user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Bank.get_user!(id)

    with {:ok, %User{} = user} <- Bank.update_user(user, user_params) do
      render(conn, "show.json", user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Bank.get_user!(id)

    with {:ok, %User{}} <- Bank.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
