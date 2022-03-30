defmodule CumbabankWeb.LoginView do
  use CumbabankWeb, :view
  alias CumbabankWeb.LoginView

  def render("token.json", %{login: token}) do
    %{data: token}
  end

end
