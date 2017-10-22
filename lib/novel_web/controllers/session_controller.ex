defmodule NovelWeb.SessionController do
  use NovelWeb, :controller

  import NovelWeb.Guardian.Plug, only: [sign_out: 1]

  def delete(conn, _params) do
    conn
    |> sign_out
    |> put_flash(:info, gettext "Signed out")
    |> redirect(to: "/")
  end
end
