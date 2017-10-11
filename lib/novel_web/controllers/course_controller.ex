defmodule NovelWeb.CourseController do
  use NovelWeb, :controller

  alias Novel.Education
  alias Novel.Education.Course

  def index(conn, _params) do
    conn |> authorize!(Course)

    courses = Education.list_courses()
    render(conn, "index.html", courses: courses)
  end

  def new(conn, _params) do
    conn |> authorize!(Course)

    changeset = Education.change_course(%Course{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"course" => course_params}) do
    conn |> authorize!(Course)

    course_params = course_params
    |> Map.merge(%{"user_id" => conn.assigns.current_user.id})

    case Education.create_course(course_params) do
      {:ok, course} ->
        conn
        |> put_flash(:info, "Course created successfully.")
        |> redirect(to: course_path(conn, :show, course))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    course = Education.get_course!(id)
    conn |> authorize!(course)

    render(conn, "show.html", course: course)
  end

  def edit(conn, %{"id" => id}) do
    course = Education.get_course!(id)
    conn |> authorize!(course)

    changeset = Education.change_course(course)
    render(conn, "edit.html", course: course, changeset: changeset)
  end

  def update(conn, %{"id" => id, "course" => course_params}) do
    course = Education.get_course!(id)
    conn |> authorize!(course)

    case Education.update_course(course, course_params) do
      {:ok, course} ->
        conn
        |> put_flash(:info, "Course updated successfully.")
        |> redirect(to: course_path(conn, :show, course))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", course: course, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    course = Education.get_course!(id)
    conn |> authorize!(course)

    {:ok, _course} = Education.delete_course(course)

    conn
    |> put_flash(:info, "Course deleted successfully.")
    |> redirect(to: course_path(conn, :index))
  end
end
