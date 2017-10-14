defmodule NovelWeb.EnrollmentController do
  use NovelWeb, :controller

  alias Novel.Education
  alias Novel.Education.Enrollment

  def new(conn, %{"invitation_code" => invitation_code}) do
    group = Education.get_group_by_invitation_code(invitation_code)

    changeset = Education.change_enrollment(%Enrollment{
      invitation_code: invitation_code
    })
    render(conn, "new.html", changeset: changeset, group: group)
  end

  def create(conn, %{"enrollment" => enrollment_params}) do
    enrollment_params = update_params(conn, enrollment_params)

    case Education.create_enrollment(enrollment_params) do
      {:ok, _enrollment} ->
        conn
        |> put_flash(:info, "Enrollment created successfully")
        |> redirect(to: "/")
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"user_id" => conn.assigns.current_user.id})
  end
end
