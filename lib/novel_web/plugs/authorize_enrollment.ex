defmodule NovelWeb.Plug.AuthorizeEnrollment do
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [halt: 1, assign: 3]
  alias NovelWeb.Router.Helpers, as: Routes

  alias Novel.University
  alias Novel.University.Enrollment
  alias Novel.University.Group

  def init(opts), do: opts

  def call(conn, _opts) do
    user = conn.assigns.current_user
    course = conn.assigns.course
    enrollment = University.get_user_enrollment(user, course)

    case enrollment do
      %Enrollment{group: %Group{}} ->
        assign(conn, :enrollment, enrollment)
      %Enrollment{} ->
        conn
        |> put_flash(:error, "Enrollment not yet approved")
        |> redirect(to: Routes.course_enrollment_path(conn, :show, enrollment))
        |> halt()
      nil ->
        conn
        |> put_flash(:error, "Not enrolled")
        |> redirect(to: Routes.course_path(conn, :show, course))
        |> halt()
    end
  end
end
