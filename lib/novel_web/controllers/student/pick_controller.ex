defmodule NovelWeb.Student.PickController do
  use NovelWeb, :controller

  alias Novel.Exam

  plug :load_parent
  plug :load_resource
  plug :put_layout, false

  def update(conn, %{"pick" => pick_params}) do
    course = conn.assigns.course
    quiz = conn.assigns.quiz
    attempt = conn.assigns.attempt
    answer = conn.assigns.answer
    pick = conn.assigns.pick

    case Exam.update_pick(pick, pick_params) do
      {:ok, _pick} ->
        conn
        |> redirect(to: student_course_quiz_attempt_answer_path(
          conn, :show, course, quiz, attempt, answer
        ))
      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(:error, gettext "Unknown error")
        |> redirect(to: student_course_quiz_attempt_answer_path(
          conn, :show, course, quiz, attempt, answer
        ))
    end
  end

  defp load_resource(conn, _opts) do
    answer = conn.assigns.answer
    pick = Exam.get_pick!(answer, conn.params["id"])

    assign(conn, :pick, pick)
  end

  defp load_parent(conn, _opts) do
    attempt = conn.assigns.attempt
    answer = Exam.get_answer!(attempt, conn.params["answer_id"])

    assign(conn, :answer, answer)
  end
end
