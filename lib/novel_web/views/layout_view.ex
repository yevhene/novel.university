defmodule NovelWeb.LayoutView do
  use NovelWeb, :view
  import NovelWeb.StringHelper

  def base_layout(assigns, do: contents) do
    render "base.html", Map.put(assigns, :contents, contents)
  end

  def full_name(user) do
    [user.first_name, user.last_name]
    |> Enum.reject(&(blank?(&1)))
    |> Enum.join(" ")
    |> coalesce(user.nickname)
  end

  def nav_item(conn, text, path) do
    content_tag :li, class: "nav-item" do
      link text, to: path, class: nav_item_link_class(conn, path)
    end
  end

  defp nav_item_link_class(conn, path) do
    if path == conn.request_path do
      "nav-link active"
    else
      "nav-link"
    end
  end
end
