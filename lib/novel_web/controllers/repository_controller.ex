defmodule NovelWeb.RepositoryController do
  use NovelWeb, :controller

  alias Novel.Remote

  plug :put_layout, false

  def index(conn, _params) do
    user = conn.assigns.current_user
    repositories = Remote.list_repositories(user)
    render(conn, "index.html", repositories: repositories)
  end
end
