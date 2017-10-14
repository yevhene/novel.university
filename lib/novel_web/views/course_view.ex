defmodule NovelWeb.CourseView do
  use NovelWeb, :view
  import NovelWeb.StringHelper

  def course_owner(%Course{user: user}) do
    [user.first_name, user.last_name]
    |> Enum.reject(&(&1 == nil))
    |> Enum.join(" ")
  end

  def course_description(course) do
    truncate(course.description)
  end

  def course_has_content?(course) do
    present?(course.description)
  end

  def nav_item(conn, text, path) do
    content_tag :li, class: "nav-item" do
      link text, to: path, class: nav_item_link_class(conn, path)
    end
  end

  defp nav_item_link_class(conn, path) do
    if path = conn.request_path do
      "nav-link active"
    else
      "nav-link"
    end
  end
end
