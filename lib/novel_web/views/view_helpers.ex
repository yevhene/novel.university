defmodule NovelWeb.ViewHelpers do
  def logged_in?(conn), do: NovelWeb.Guardian.Plug.authenticated?(conn)
  def current_user(conn), do: NovelWeb.Guardian.Plug.current_resource(conn)
end
