defmodule NovelWeb.Student.CourseController do
  use NovelWeb, :controller

  plug :put_layout, "student.html"

  def show(conn, _params) do
    render(conn, "show.html")
  end
end
