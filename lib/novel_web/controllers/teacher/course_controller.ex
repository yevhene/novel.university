defmodule NovelWeb.Teacher.CourseController do
  use NovelWeb, :controller

  alias Novel.University
  alias Novel.University.Course

  plug :put_layout, "teacher.html" when action not in [:new, :create]

  def new(conn, _params) do
    changeset = University.change_course(%Course{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"course" => course_params}) do
    course_params = update_params(conn, course_params)

    case University.create_course(course_params) do
      {:ok, course} ->
        conn
        |> put_flash(:info, gettext "Course created successfully")
        |> redirect(to: course_path(conn, :show, course))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    render(conn, "show.html")
  end

  def edit(conn, _params) do
    course = conn.assigns.course
    changeset = University.change_course(course)
    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"course" => course_params}) do
    course = conn.assigns.course
    course_params = update_params(conn, course_params)

    case University.update_course(course, course_params) do
      {:ok, course} ->
        conn
        |> put_flash(:info, gettext "Course updated successfully")
        |> redirect(to: teacher_course_path(conn, :show, course))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    course = conn.assigns.course

    case University.delete_course(course) do
      {:ok, _course} ->
        conn
        |> put_flash(:info, gettext "Course deleted successfully")
        |> redirect(to: course_path(conn, :index))
      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(:error, gettext "Course can't be deleted")
        |> redirect(to: course_path(conn, :show, course))
    end
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"head_id" => conn.assigns.current_user.id})
  end
end
