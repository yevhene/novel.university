defmodule NovelWeb.CourseView do
  use NovelWeb, :view

  import NovelWeb.StringHelpers
  import NovelWeb.UserHelpers
  import NovelWeb.MarkdownHelpers

  alias Novel.University
  alias Novel.University.Enrollment
  alias Novel.University.Group

  def course_description(course) do
    truncate(course.description)
  end

  def course_has_content?(course) do
    present?(course.description)
  end

  def course_style(course) do
    if University.is_finished?(course) do
      ""
    else
      "border-primary"
    end
  end
end
