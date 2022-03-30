defmodule CumbabankWeb.UserView do
  use CumbabankWeb, :view
  alias CumbabankWeb.UserView
  alias CumbabankWeb.AccountView

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("token.json", %{login: token}) do
    %{data: token}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("show_account.json", %{account: account}) do
    data = %{
      id: account.id,
      name: account.name,
      cpf: account.cpf,
      email: account.email,
      initial_balance: account.initial_balance
    }

    %{account: data}
  end

  def render("user.json", %{user: user}) do
    %{
      id: user.id,
      name: user.name,
      cpf: user.cpf,
      email: user.email,
      password_hash: user.password_hash
    }
  end

  def render("invalid_pass.json", _assigns) do
    %{errors: %{detail: dgettext("errors", "Invalid user or password")}}
  end
end
