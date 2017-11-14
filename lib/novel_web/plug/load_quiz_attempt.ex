defmodule NovelWeb.Plug.LoadQuizAttempt do
  import Plug.Conn, only: [assign: 3]

  alias Novel.Exam

  def init(opts), do: opts

  def call(conn, _opts) do
    enrollment = conn.assigns.enrollment
    attempt = Exam.get_attempt!(enrollment, conn.params["attempt_id"])
    quiz = attempt.quiz

    conn
    |> assign(:quiz, quiz)
    |> assign(:attempt, attempt)
  end
end
