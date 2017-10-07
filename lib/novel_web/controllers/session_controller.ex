defmodule NovelWeb.SessionController do
  use NovelWeb, :controller

  def delete(conn, _params) do
    conn
    |> NovelWeb.Guardian.Plug.sign_out
    |> put_flash(:info, "Signed out")
    |> redirect(to: "/")
  end
end
