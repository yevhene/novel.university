defmodule NovelWeb.Student.QuizController do
  use NovelWeb, :controller

  alias Novel.Exam
  alias Novel.Exam.Quiz

  plug :load_resource when action in [:show]
  plug :put_layout, "student.html"

  def index(conn, _params) do
    course = conn.assigns.course
    quizzes = Exam.list_active_quizzes(course)
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
end
