defmodule NovelWeb.Plug.AuthorizeEnrollment do
  import NovelWeb.Gettext
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [halt: 1, send_resp: 3]
  alias NovelWeb.Router.Helpers, as: Routes

  alias Novel.University.Enrollment
  alias Novel.University.Group

  def init(opts), do: opts

  def call(conn, _opts) do
    enrollment = conn.assigns.enrollment

    case enrollment do
      %Enrollment{group: %Group{}} ->
        conn
      %Enrollment{} ->
        conn |> enrollment_not_approved_error_response()
      nil ->
        conn |> not_enrolled_error_response()
    end
  end

  defp enrollment_not_approved_error_response(conn) do
    format = conn.private.phoenix_format
    enrollment = conn.assigns.enrollment

    case format do
      "html" ->
        conn
        |> put_flash(:error, gettext "Your enrollment is not yet approved")
        |> redirect(to: Routes.course_enrollment_path(conn, :show, enrollment))
        |> halt()
      _ ->
        conn
        |> send_resp(403, "")
        |> halt()
    end
  end

  defp not_enrolled_error_response(conn) do
    format = conn.private.phoenix_format
    course = conn.assigns.course

    case format do
      "html" ->
        conn
        |> put_flash(:error, gettext "You are not enrolled")
        |> redirect(to: Routes.course_path(conn, :show, course))
        |> halt()
      _ ->
        conn
        |> send_resp(403, "")
        |> halt()
    end
  end
end
