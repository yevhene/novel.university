defmodule NovelWeb.Student.EnrollmentController do
  use NovelWeb, :controller

  alias Novel.University
  alias Novel.University.Enrollment

  plug :load_course
  plug :authorize_resources when action in [:new, :create]
  plug :load_and_authorize_resource when action in [:show, :delete]
  plug :put_layout, "student.html"

  def new(conn, _params) do
    changeset = University.change_enrollment(%Enrollment{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, _params) do
    course = conn.assigns.course
    enrollment_params = update_params(conn, %{})

    case University.create_enrollment(enrollment_params) do
      {:ok, _enrollment} ->
        conn
        |> put_flash(:info, "Enrollment created successfully")
        |> redirect(to: course_path(conn, :show, course))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    enrollment = conn.assigns.enrollment
    render(conn, "show.html", enrollment: enrollment)
  end

  def delete(conn, _params) do
    course = conn.assigns.course
    enrollment = conn.assigns.enrollment
    {:ok, _enrollment} = University.delete_enrollment(enrollment)

    conn
    |> put_flash(:info, "Enrollment deleted successfully")
    |> redirect(to: course_path(conn, :show, course))
  end

  defp load_course(conn, _opts) do
    course = University.get_course!(conn.params["course_id"])
    assign(conn, :course, course)
  end

  defp authorize_resources(conn, _params) do
    conn |> authorize!(Enrollment)
  end

  defp load_and_authorize_resource(conn, _opts) do
    course = conn.assigns.course
    user = conn.assigns.current_user
    enrollment = University.get_user_enrollment!(user, course)
    conn |> authorize!(enrollment)
    assign(conn, :enrollment, enrollment)
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"course_id" => conn.assigns.course.id})
    |> Map.merge(%{"user_id" => conn.assigns.current_user.id})
  end
end
