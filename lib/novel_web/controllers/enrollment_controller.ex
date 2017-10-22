defmodule NovelWeb.EnrollmentController do
  use NovelWeb, :controller

  alias Novel.University

  def create(conn, _params) do
    course = conn.assigns.course
    enrollment_params = update_params(conn, %{})

    case University.create_enrollment(enrollment_params) do
      {:ok, _enrollment} ->
        conn
        |> put_flash(:info, gettext "Enrollment created successfully")
        |> redirect(to: course_path(conn, :show, course))
      {:error, _} ->
        conn
        |> put_flash(:error, gettext "Enrollment failed. Try again later")
        |> redirect(to: course_path(conn, :show, course))
    end
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"course_id" => conn.assigns.course.id})
    |> Map.merge(%{"user_id" => conn.assigns.current_user.id})
  end
end
