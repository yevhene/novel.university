defmodule NovelWeb.Guardian.Helpers do
  def logged_in?(conn), do: NovelWeb.Guardian.Plug.current_resource(conn) != nil
  def current_user(conn), do: NovelWeb.Guardian.Plug.current_resource(conn)
end
