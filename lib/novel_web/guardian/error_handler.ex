defmodule NovelWeb.Guardian.ErrorHandler do
  import NovelWeb.Gettext
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> put_flash(:error, gettext "Unauthenticated")
    |> redirect(to: "/")
  end
end
