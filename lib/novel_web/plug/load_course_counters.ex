defmodule NovelWeb.Plug.LoadCourseCounters do
  import Plug.Conn, only: [assign: 3]

  alias Novel.University
  alias Novel.Assignment

  def init(opts), do: opts

  def call(conn, _opts) do
    course = conn.assigns.course

    new_enrollments_count = University.new_enrollments_count(course)
    new_submissions_count = Assignment.new_submissions_count(course)

    conn
    |> assign(:new_enrollments_count, new_enrollments_count)
    |> assign(:new_submissions_count, new_submissions_count)
  end
end
