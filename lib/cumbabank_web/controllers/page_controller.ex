defmodule CumbabankWeb.PageController do
  use CumbabankWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
