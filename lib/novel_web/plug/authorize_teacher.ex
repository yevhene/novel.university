defmodule NovelWeb.Plug.AuthorizeTeacher do
  import NovelWeb.Gettext
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [halt: 1, send_resp: 3]

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = conn.assigns.current_user
    if current_user.is_teacher do
      conn
    else
      conn |> error_response
    end
  end

  defp error_response(conn) do
    format = conn.private.phoenix_format

    case format do
      "html" ->
        conn
        |> put_flash(:error, gettext "You should be a teacher")
        |> redirect(to: "/")
        |> halt()
      _ ->
        conn
        |> send_resp(403, "")
        |> halt()
    end
  end
end
