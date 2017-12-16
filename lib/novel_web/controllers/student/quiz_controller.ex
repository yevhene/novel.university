defmodule NovelWeb.Student.QuizController do
  use NovelWeb, :controller

  alias Novel.Exam

  plug :load_resource when action in [:show]
  plug :load_attempts when action in [:show]
  plug :put_layout, "student.html"

  def index(conn, _params) do
    course = conn.assigns.course
    enrollment = conn.assigns.enrollment
    quizzes = Exam.list_quizzes(course, enrollment)
    render(conn, "index.html", quizzes: quizzes)
  end

  def show(conn, _params) do
    quiz = conn.assigns.quiz
    render(conn, "show.html", quiz: quiz)
  end

  defp load_resource(conn, _opts) do
    quiz = Exam.get_quiz!(conn.params["id"])
    assign(conn, :quiz, quiz)
  end

  defp load_attempts(conn, _opts) do
    enrollment = conn.assigns.enrollment
    quiz = conn.assigns.quiz
    attempts = Exam.list_attempts(enrollment, quiz)
    assign(conn, :attempts, attempts)
  end
end
