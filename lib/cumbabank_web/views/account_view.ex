defmodule CumbabankWeb.AccountView do
  use CumbabankWeb, :view
  alias CumbabankWeb.AccountView

  def render("index.json", %{accounts: accounts}) do
    %{data: render_many(accounts, AccountView, "account.json")}
  end

  def render("show.json", %{account: account}) do
    %{data: render_one(account, AccountView, "account.json")}
  end

  def render("balance.json", %{account: account}) do
    %{current_balance: account.current_balance}
  end

  def render("account.json", %{account: account}) do
    %{
      id: account.id,
      initial_balance: account.initial_balance,
      current_balance: account.current_balance
    }
  end
end
