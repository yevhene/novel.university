defmodule NovelWeb.Teacher.RepositoryController do
  use NovelWeb, :controller

  alias Novel.Remote
  alias Novel.Remote.Repository
  alias Novel.University

  plug :load_resource when action in [:show, :delete]
  plug :put_layout, "teacher.html"

  def new(conn, _params) do
    changeset = Remote.change_repository(%Repository{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"repository" => repository_params}) do
    course = conn.assigns.course
    case Remote.create_repository(repository_params) do
      {:ok, repository} ->
        {:ok, _course} = University.update_course_repository(course, repository)

        conn
        |> put_flash(:info, gettext "Repository linked")
        |> redirect(
          to: teacher_course_repository_path(conn, :show, course)
        )
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    repository = conn.assigns.repository
    render(conn, "show.html", repository: repository)
  end

  def delete(conn, _params) do
    course = conn.assigns.course
    repository = conn.assigns.respository
    {:ok, _repository} = Remote.delete_repository(repository)

    conn
    |> put_flash(:info, gettext "Repository unlinked")
    |> redirect(to: teacher_course_repository_path(conn, :show, course))
  end

  defp load_resource(conn, _opts) do
    course = conn.assigns.course
    repository = Remote.get_repository(course.repository_id)
    assign(conn, :repository, repository)
  end
end
