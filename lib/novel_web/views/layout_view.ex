defmodule NovelWeb.LayoutView do
  use NovelWeb, :view

  import NovelWeb.UserHelper

  def base_layout(assigns, do: contents) do
    render "base.html", Map.put(assigns, :contents, contents)
  end

  def nav_item(conn, text, path) do
    content_tag :li, class: "nav-item" do
      link text,
        to: path, class: nav_item_link_class(conn, path)
    end
  end

  defp nav_item_link_class(conn, path) do
    if nav_item_active?(path, conn.request_path) do
      "nav-link active"
    else
      "nav-link"
    end
  end

  defp nav_item_active?(path, current_path) do
    current_path =~ ~r{#{path}(/edit|/new)?(/\d+.*)?$}
  end
end
