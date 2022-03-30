defmodule Cumbabank.Auth.ErrorHandler do
  import Plug.Conn, only: [send_resp: 3, put_resp_header: 3]
  import Cumbabank.Gettext

  def auth_error(
        conn,
        error \\ dgettext("errors", "Unauthorized"),
        _opts \\ %{}
      ) do
    error =
      if is_tuple(error) do
        error |> elem(1) |> to_string()
      else
        to_string(error)
      end

    conn
    |> put_resp_header("content-type", "application/json")
    |> send_resp(
      :unauthorized,
      Jason.encode!(%{errors: %{detail: error}})
    )
  end
end
