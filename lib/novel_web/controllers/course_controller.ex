defmodule NovelWeb.CourseController do
  use NovelWeb, :controller

  alias Novel.University

  plug :load_resource when action in [:show]
  plug :load_enrollment when action in [:show]

  def index(conn, _params) do
    courses = University.list_courses()
    finished_courses = University.list_finished_courses()
    render(conn, "index.html",
           courses: courses,
           finished_courses: finished_courses)
  end

  def show(conn, _params) do
    course = conn.assigns.course
    render(conn, "show.html", course: course)
  end

  defp load_resource(conn, _opts) do
    course = University.get_course!(conn.params["id"])
    assign(conn, :course, course)
  end

  defp load_enrollment(conn, _opts) do
    course = conn.assigns.course
    user = conn.assigns.current_user
    enrollment = University.get_user_enrollment(user, course)
    assign(conn, :enrollment, enrollment)
  end
end
