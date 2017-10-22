defmodule NovelWeb.Guardian.ErrorHandler do
  import NovelWeb.Gettext
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [send_resp: 3]

  def auth_error(conn, {_type, _reason}, _opts) do
    format = conn.private.phoenix_format

    case format do
      "html" ->
        conn
        |> put_flash(:error, gettext "Unauthenticated")
        |> redirect(to: "/")
      _ ->
        conn
        |> send_resp(403, "")
    end
  end
end
