defmodule CumbabankWeb.TransactionController do
  use CumbabankWeb, :controller

  alias Cumbabank.Bank
  alias Cumbabank.Bank.Transaction

  plug(
    Guardian.Plug.EnsureAuthenticated,
    [key: :user]
  )

  action_fallback CumbabankWeb.FallbackController

  def index(conn, _params) do
    transactions = Bank.list_transactions()
    render(conn, "index.json", transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    with {:ok, %Transaction{} = transaction} <- Transaction.create_transaction(transaction_params) do
      conn
      |> put_status(:created)
      |> render("show.json", transaction: transaction)
    end
  end

  def get_transactions_between(conn, %{"initial_date" => initial_date, "end_date" => end_date}) do
    with transactions <- Transaction.get_transactions_by_period(initial_date, end_date) do
      conn
      |> put_status(:ok)
      |> render("index.json", transactions: transactions)
    end
  end

  def create_account_transaction(conn, %{"transaction" => transaction_params}) do
    with {:ok, %Transaction{} = transaction} <- Transaction.create_account_transaction(transaction_params) do
      conn
      |> put_status(:created)
      |> render("show.json", transaction: transaction)
    else
      {:error, error} ->
        conn
        |> put_status(:not_acceptable)
        |> json(%{errors: %{message: error}})
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Bank.get_transaction!(id)
    render(conn, "show.json", transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Bank.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <- Bank.update_transaction(transaction, transaction_params) do
      render(conn, "show.json", transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Bank.get_transaction!(id)

    with {:ok, %Transaction{}} <- Bank.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end
end
