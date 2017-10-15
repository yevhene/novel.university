defmodule NovelWeb.CourseView do
  use NovelWeb, :view
  import NovelWeb.StringHelper

  def course_description(course) do
    truncate(course.description)
  end

  def course_has_content?(course) do
    present?(course.description)
  end
end
