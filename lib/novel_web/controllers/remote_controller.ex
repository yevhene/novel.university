defmodule NovelWeb.RemoteController do
  use NovelWeb, :controller

  alias Novel.Remote.Api

  plug :put_layout, false

  def index(conn, params) do
    user = conn.assigns.current_user
    remotes = Api.list_remotes(user,
      visibility: String.to_atom(params["visibility"] || "public")
    )
    render(conn, "index.html", remotes: remotes)
  end
end
