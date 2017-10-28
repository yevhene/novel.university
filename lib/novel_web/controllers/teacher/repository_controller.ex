defmodule NovelWeb.Teacher.RepositoryController do
  use NovelWeb, :controller

  alias Novel.University

  plug :put_layout, "teacher.html"

  def edit(conn, _params) do
    course = conn.assigns.course
    changeset = University.change_course_repository(course)
    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"course" => course_params}) do
    course = conn.assigns.course

    case University.update_course_repository(course, course_params) do
      {:ok, course} ->
        conn
        |> put_flash(:info, gettext "Repository linked")
        |> redirect(to: teacher_course_repository_path(conn, :show, course))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    course = conn.assigns.course
    render(conn, "show.html", repository: course.repository)
  end

  def delete(conn, _params) do
    course = conn.assigns.course
    {:ok, _course} = University.delete_course_repository(course)

    conn
    |> put_flash(:info, gettext "Repository unlinked")
    |> redirect(to: teacher_course_repository_path(conn, :show, course))
  end
end
