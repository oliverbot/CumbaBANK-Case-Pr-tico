defmodule CumbabankWeb.LoginController do
  use CumbabankWeb, :controller

  alias Cumbabank.Bank
  alias Cumbabank.Auth
  alias CumbabankWeb.ErrorView

  action_fallback CumbabankWeb.FallbackController

  def login(conn, params = %{"password" => password}) do
    login = {:email, params["email"]}

    case Bank.login(login, password) do
      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> put_view(ErrorView)
        |> render("wrong_credentials.json")

      {:ok, user} ->
        login_user = %{
          __struct__: user.__struct__,
          id: user.id,
          email: user.email,
          cpf: user.cpf,
          name: user.name,
        }

        with {:ok, token, _claims} <- Auth.encode_and_sign(login_user) do

          render(conn, "token.json",
            login: token
          )
        end
    end
  end


end
