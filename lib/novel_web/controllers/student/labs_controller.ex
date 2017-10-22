defmodule NovelWeb.Student.LabController do
  use NovelWeb, :controller

  alias Novel.University

  plug :load_resource when action in [:show]
  plug :load_submissions when action in [:show]
  plug :put_layout, "student.html"

  def index(conn, _params) do
    course = conn.assigns.course
    labs = University.list_labs(course)
    render(conn, "index.html", labs: labs)
  end

  def show(conn, _params) do
    lab = conn.assigns.lab
    render(conn, "show.html", lab: lab)
  end

  defp load_resource(conn, _opts) do
    lab = University.get_lab!(conn.params["id"])
    assign(conn, :lab, lab)
  end

  defp load_submissions(conn, _opts) do
    enrollment = conn.assigns.enrollment
    lab = conn.assigns.lab
    submissions = University.list_submissions(enrollment, lab)
    assign(conn, :submissions, submissions)
  end
end
