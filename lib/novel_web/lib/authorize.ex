defmodule NovelWeb.Authorize do
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [halt: 1]
  import Canada.Can, only: [can?: 3]

  def authorize!(conn, subject) do
    authorize!(conn, conn.private.phoenix_action, subject)
  end

  def authorize!(conn, action, subject) do
    if can?(conn.assigns.current_user, action, subject) do
      conn
    else
      conn
      |> put_flash(:error, "Unauthorized")
      |> redirect(to: "/")
      |> halt()
    end
  end
end
