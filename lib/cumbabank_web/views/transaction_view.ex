defmodule CumbabankWeb.TransactionView do
  use CumbabankWeb, :view
  alias CumbabankWeb.TransactionView

  def render("index.json", %{transactions: transactions}) do
    %{data: render_many(transactions, TransactionView, "transaction.json")}
  end

  def render("show.json", %{transaction: transaction}) do
    %{data: render_one(transaction, TransactionView, "transaction.json")}
  end

  def render("transaction.json", %{transaction: transaction}) do
    %{
      id: transaction.id,
      amount: transaction.amount,
      returned: transaction.returned,
      from_account: transaction.from_account,
      to_account: transaction.to_account
    }
  end
end
