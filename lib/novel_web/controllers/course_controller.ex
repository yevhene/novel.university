defmodule NovelWeb.CourseController do
  use NovelWeb, :controller

  alias Novel.University
  alias Novel.University.Course

  plug :authorize_resources when action in [:index]
  plug :load_and_authorize_resource when action in [:show]
  plug :load_enrollment when action in [:show]

  def index(conn, _params) do
    courses = University.list_courses()
    render(conn, "index.html", courses: courses)
  end

  def show(conn, _params) do
    course = conn.assigns.course
    render(conn, "show.html", course: course)
  end

  defp authorize_resources(conn, _params) do
    conn |> authorize!(Course)
  end

  defp load_and_authorize_resource(conn, _opts) do
    course = University.get_course!(conn.params["id"])
    conn |> authorize!(course)
    assign(conn, :course, course)
  end

  defp load_enrollment(conn, _opts) do
    course = conn.assigns.course
    user = conn.assigns.current_user
    enrollment = University.get_enrollment(course.id, user.id)
    assign(conn, :enrollment, enrollment)
  end
end
