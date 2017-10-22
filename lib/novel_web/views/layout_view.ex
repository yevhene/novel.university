defmodule NovelWeb.LayoutView do
  use NovelWeb, :view

  import NovelWeb.UserHelper

  def base_layout(assigns, do: contents) do
    render "base.html", Map.put(assigns, :contents, contents)
  end

  def nav_item(conn, text, path, counter \\ 0) do
    content_tag :li, class: "nav-item" do
      link to: path, class: nav_item_link_class(conn, path) do
        if counter == 0 do
          content_tag(:span, text)
        else
          [
            content_tag(:span, "#{text} "),
            content_tag(:span, counter, class: "badge badge-primary"),
            content_tag(:span, gettext("New enrollments"), class: "sr-only")
          ]
        end
      end
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
