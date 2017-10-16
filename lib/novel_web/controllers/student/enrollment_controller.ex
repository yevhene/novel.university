defmodule NovelWeb.Student.EnrollmentController do
  use NovelWeb, :controller

  alias Novel.University
  alias Novel.University.Enrollment

  plug :load_resource when action in [:show]

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

  defp load_resource(conn, _opts) do
    course = conn.assigns.course
    user = conn.assigns.current_user
    enrollment = University.get_user_enrollment!(user, course)
    assign(conn, :enrollment, enrollment)
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"course_id" => conn.assigns.course.id})
    |> Map.merge(%{"user_id" => conn.assigns.current_user.id})
  end
end
