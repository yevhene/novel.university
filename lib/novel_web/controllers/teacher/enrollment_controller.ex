defmodule NovelWeb.Teacher.EnrollmentController do
  use NovelWeb, :controller

  alias Novel.University

  plug :load_resource when action in [:show, :edit, :update]
  plug :load_groups when action in [:edit, :update]
  plug :put_layout, "teacher.html"

  def index(conn, _params) do
    course = conn.assigns.course
    enrollments = University.list_enrollments(course)
    render(conn, "index.html", enrollments: enrollments)
  end

  def show(conn, _params) do
    enrollment = conn.assigns.enrollment
    render(conn, "show.html", enrollment: enrollment)
  end

  def edit(conn, _params) do
    enrollment = conn.assigns.enrollment
    changeset = University.change_enrollment(enrollment)
    render(conn, "edit.html", changeset: changeset)
  end

  def update(conn, %{"enrollment" => enrollment_params}) do
    course = conn.assigns.course
    enrollment = conn.assigns.enrollment

    case University.update_enrollment_group(enrollment, enrollment_params) do
      {:ok, enrollment} ->
        conn
        |> put_flash(:info, gettext "Enrollment updated successfully")
        |> redirect(
          to: teacher_course_enrollment_path(conn, :show, course, enrollment)
        )
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  defp load_resource(conn, _opts) do
    enrollment = University.get_enrollment!(conn.params["id"])
    assign(conn, :enrollment, enrollment)
  end

  defp load_groups(conn, _opts) do
    course = conn.assigns.course
    groups = University.list_groups(course)
    assign(conn, :groups, groups)
  end
end
