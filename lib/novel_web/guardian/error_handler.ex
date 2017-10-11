defmodule NovelWeb.Guardian.ErrorHandler do
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]

  def auth_error(conn, {_type, reason}, _opts) do
    conn
    |> put_flash(:error, "Unauthenticated")
    |> redirect(to: "/")
  end
end
