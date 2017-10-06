defmodule NovelWeb.PageController do
  use NovelWeb, :controller

  def index(conn, _params) do
    conn
    |> render("index.html")
  end
end
