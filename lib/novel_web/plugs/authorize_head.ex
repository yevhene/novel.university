defmodule NovelWeb.Plug.AuthorizeHead do
  import NovelWeb.Gettext
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [halt: 1, send_resp: 3]

  def init(opts), do: opts

  def call(conn, _opts) do
    course = conn.assigns.course
    current_user = conn.assigns.current_user
    if course.head.id == current_user.id do
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
        |> put_flash(:error, gettext "You should be a course head")
        |> redirect(to: "/")
        |> halt()
      _ ->
        conn
        |> send_resp(403, "")
        |> halt()
    end
  end
end
