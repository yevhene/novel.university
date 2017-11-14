defmodule NovelWeb.Plug.CheckQuizAttemptTimeScope do
  import NovelWeb.Gettext
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [halt: 1, send_resp: 3]

  alias NovelWeb.Router.Helpers, as: Routes
  alias Novel.Exam

  def init(opts), do: opts

  def call(conn, _opts) do
    attempt = conn.assigns.attempt

    if Exam.is_active? attempt do
      conn
    else
      error_response(conn)
    end
  end

  defp error_response(conn) do
    course = conn.assigns.course
    quiz = conn.assigns.quiz
    format = conn.private.phoenix_format

    case format do
      "html" ->
        conn
        |> put_flash(:error, gettext "Attempt time elapsed")
        |> redirect(to: Routes.student_course_quiz_path(
          conn, :show, course, quiz
        ))
        |> halt()
      _ ->
        conn
        |> send_resp(403, "")
        |> halt()
    end
  end
end
