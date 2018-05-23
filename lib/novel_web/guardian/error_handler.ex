defmodule NovelWeb.Guardian.ErrorHandler do
  import NovelWeb.Gettext
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [halt: 1, send_resp: 3]
  import NovelWeb.Guardian.Plug, only: [sign_out: 1]

  def auth_error(conn, {_type, _reason}, _opts) do
    format = conn.private.phoenix_format

    case format do
      "html" ->
        conn
        |> sign_out
        |> put_flash(:error, gettext "Authorization expired")
        |> redirect(to: "/")
        |> halt()
      _ ->
        conn
        |> sign_out
        |> send_resp(403, "")
        |> halt()
    end
  end
end
