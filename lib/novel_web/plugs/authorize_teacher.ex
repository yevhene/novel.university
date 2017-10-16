defmodule NovelWeb.Plug.AuthorizeTeacher do
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [halt: 1]

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = conn.assigns.current_user
    if current_user.is_teacher do
      conn
    else
      conn
      |> put_flash(:error, "Should be teacher")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
