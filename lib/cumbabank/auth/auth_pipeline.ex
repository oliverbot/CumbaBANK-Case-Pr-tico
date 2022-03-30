defmodule Cumbabank.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :cumbabank,
    module: Cumbabank.Auth,
    error_handler: Cumbabank.Auth.ErrorHandler

  plug(Guardian.Plug.VerifyHeader, key: :user)
  plug(Guardian.Plug.LoadResource, key: :user, allow_blank: true)
end
