defmodule NovelWeb.Plug.AuthorizeHead do
  import NovelWeb.Gettext
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [halt: 1]

  def init(opts), do: opts

  def call(conn, _opts) do
    course = conn.assigns.course
    current_user = conn.assigns.current_user
    if course.head.id == current_user.id do
      conn
    else
      conn
      |> put_flash(:error, gettext "You should be a course head")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
