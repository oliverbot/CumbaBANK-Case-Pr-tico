defmodule CumbabankWeb.AccountController do
  use CumbabankWeb, :controller

  alias Cumbabank.Bank.Account
  alias Cumbabank.Bank.User
  alias Cumbabank.Bank
  alias Cumbabank.Auth

  alias CumbabankWeb.ErrorView

  action_fallback CumbabankWeb.FallbackController

  def index(conn, _params) do
    accounts = Bank.list_accounts()
    render(conn, "index.json", accounts: accounts)
  end

  def get_current_balance(conn, params) do
    with %User{} = user <- Auth.Plug.current_resource(conn, key: :user) do
      account = Account.get_account_by_user_id(user.id)

      conn
      |> put_status(:ok)
      |> render("balance.json", %{account: account})
    else
      {:error, _reason} ->
        conn
        |> put_view(ErrorView)
        |> render("unauthenticated.json")
    end

  end

  def create(conn, %{"account" => account_params}) do
    with {:ok, %Account{} = account} <- Bank.create_account(account_params) do
      conn
      |> put_status(:created)
      |> render("show.json", account: account)
    end
  end

  def show(conn, %{"id" => id}) do
    account = Bank.get_account!(id)
    render(conn, "show.json", account: account)
  end

  def update(conn, %{"id" => id, "account" => account_params}) do
    account = Bank.get_account!(id)

    with {:ok, %Account{} = account} <- Bank.update_account(account, account_params) do
      render(conn, "show.json", account: account)
    end
  end

  def delete(conn, %{"id" => id}) do
    account = Bank.get_account!(id)

    with {:ok, %Account{}} <- Bank.delete_account(account) do
      send_resp(conn, :no_content, "")
    end
  end
end
