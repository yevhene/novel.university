defmodule NovelWeb.Guardian.ErrorHandler do
  use NovelWeb, :controller

  def auth_error(conn, {_type, reason}, _opts) do
    conn
    |> put_flash(:error, "Auth Error: #{reason}")
    |> redirect(to: "/")
  end
end
