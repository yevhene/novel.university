defmodule NovelWeb.Teacher.EnrollmentController do
  use NovelWeb, :controller

  alias Novel.University

  plug :load_resource when action in [:show, :edit, :update, :delete]
  plug :load_groups when action in [:edit, :update]
  plug :put_layout, "teacher.html"

  def index(conn, _params) do
    course = conn.assigns.course
    enrollments = University.list_enrollments(course)

    case get_format(conn) do
      "csv" ->
        conn
        |> put_resp_content_type("text/csv")
        |> put_resp_header(
          "Content-Disposition",
          "attachment; filename=\"enrollments.csv\""
        )
        |> render("index.csv", enrollments: enrollments)
      "html" ->
        render(conn, "index.html", enrollments: enrollments)
    end
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

    case University.update_enrollment(enrollment, enrollment_params) do
      {:ok, enrollment} ->
        conn
        |> put_flash(:info, gettext "Enrollment updated successfully")
        |> redirect(to: teacher_course_enrollment_path(
          conn, :show, course, enrollment
        ))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    course = conn.assigns.course
    enrollment = conn.assigns.enrollment

    case University.delete_enrollment(enrollment) do
      {:ok, _enrollment} ->
        conn
        |> put_flash(:info, gettext "Enrollment deleted successfully")
        |> redirect(to: teacher_course_enrollment_path(
          conn, :index, course
        ))
      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(:error, gettext "Enrollment can't be deleted")
        |> redirect(to: teacher_course_enrollment_path(
          conn, :index, course
        ))
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
