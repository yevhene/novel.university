defmodule NovelWeb.Teacher.Repositories.RemoteController do
  use NovelWeb, :controller

  alias Novel.Remote.Api

  plug :put_layout, false

  def index(conn, _params) do
    user = conn.assigns.current_user
    remotes = Api.list_remotes(user, visibility: :all)
    render(conn, "index.html", remotes: remotes)
  end
end
