defmodule NovelWeb.Teacher.AttemptController do
  use NovelWeb, :controller

  alias Novel.Exam

  plug :put_layout, "teacher.html"

  def index(conn, _params) do
    course = conn.assigns.course
    attempts = Exam.list_attempts(course)
    render(conn, "index.html", attempts: attempts)
  end
end
