defmodule NovelWeb.Student.AnswerController do
  use NovelWeb, :controller

  alias Novel.Exam

  plug :load_parent
  plug :load_resource
  plug :put_layout, "student.html"

  def edit(conn, _params) do
    render(conn, "edit.html")
  end

  def update(conn, _params) do
    conn
  end

  defp load_resource(conn, _opts) do
    attempt = conn.assigns.attempt
    answer = Exam.get_answer!(attempt, conn.params["id"])
    index = Enum.find_index(attempt.answers, fn a -> a.id == answer.id end)

    conn
    |> assign(:answer, answer)
    |> assign(:index, index)
  end

  defp load_parent(conn, _opts) do
    enrollment = conn.assigns.enrollment
    attempt = Exam.get_attempt!(enrollment, conn.params["attempt_id"])
    course = conn.assigns.course
    quiz = attempt.quiz

    if Exam.is_attempt_active? attempt do
      conn
      |> assign(:quiz, quiz)
      |> assign(:attempt, attempt)
    else
      conn
      |> put_flash(:error, gettext "Attempt time elapsed")
      |> redirect(to: student_course_quiz_path(
        conn, :show, course, quiz
      ))
      |> halt()
     end
  end
end
