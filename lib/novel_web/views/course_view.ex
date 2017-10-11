defmodule NovelWeb.CourseView do
  use NovelWeb, :view
  import NovelWeb.FormatHelper

  def course_owner(%Course{user: user}) do
    [user.first_name, user.last_name]
    |> Enum.reject(&(&1 == nil))
    |> Enum.join(" ")
  end

  def course_description(course) do
    truncate(course.description)
  end
end
