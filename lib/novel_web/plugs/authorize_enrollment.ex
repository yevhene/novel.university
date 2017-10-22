defmodule NovelWeb.Plug.AuthorizeEnrollment do
  import NovelWeb.Gettext
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [halt: 1]
  alias NovelWeb.Router.Helpers, as: Routes

  alias Novel.University.Enrollment
  alias Novel.University.Group

  def init(opts), do: opts

  def call(conn, _opts) do
    course = conn.assigns.course
    enrollment = conn.assigns.enrollment

    case enrollment do
      %Enrollment{group: %Group{}} ->
        conn
      %Enrollment{} ->
        conn
        |> put_flash(:error, gettext "Your enrollment is not yet approved")
        |> redirect(to: Routes.course_enrollment_path(conn, :show, enrollment))
        |> halt()
      nil ->
        conn
        |> put_flash(:error, gettext "You are not enrolled")
        |> redirect(to: Routes.course_path(conn, :show, course))
        |> halt()
    end
  end
end
