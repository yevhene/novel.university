defmodule NovelWeb.Teacher.QuizController do
  use NovelWeb, :controller

  alias Novel.Exam
  alias Novel.Exam.Quiz

  plug :load_resource when action in [:show, :edit, :update, :delete]
  plug :load_questions when action in [:show]
  plug :put_layout, "teacher.html"

  def index(conn, _params) do
    course = conn.assigns.course
    quizzes = Exam.list_quizzes(course)
    render(conn, "index.html", quizzes: quizzes)
  end

  def new(conn, _params) do
    course = conn.assigns.course
    changeset = Exam.change_quiz(%Quiz{course_id: course.id})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"quiz" => quiz_params}) do
    course = conn.assigns.course
    quiz_params = update_params(conn, quiz_params)

    case Exam.create_quiz(quiz_params) do
      {:ok, _quiz} ->
        conn
        |> put_flash(:info, gettext "Quiz created successfully")
        |> redirect(to: teacher_course_quiz_path(conn, :index, course))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    quiz = conn.assigns.quiz
    render(conn, "show.html", quiz: quiz)
  end

  def edit(conn, _params) do
    quiz = conn.assigns.quiz
    changeset = Exam.change_quiz(quiz)
    render(conn, "edit.html", quiz: quiz, changeset: changeset)
  end

  def update(conn, %{"quiz" => quiz_params}) do
    course = conn.assigns.course
    quiz = conn.assigns.quiz
    quiz_params = update_params(conn, quiz_params)

    case Exam.update_quiz(quiz, quiz_params) do
      {:ok, quiz} ->
        conn
        |> put_flash(:info, gettext "Quiz updated successfully")
        |> redirect(to: teacher_course_quiz_path(conn, :show, course, quiz))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", quiz: quiz, changeset: changeset)
    end
  end

  def delete(conn, _params) do
    course = conn.assigns.course
    quiz = conn.assigns.quiz

    case Exam.delete_quiz(quiz) do
      {:ok, _quiz} ->
        conn
        |> put_flash(:info, gettext "Quiz deleted successfully")
        |> redirect(to: teacher_course_quiz_path(conn, :index, course))
      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(:error, gettext "Quiz can't be deleted")
        |> redirect(to: teacher_course_quiz_path(conn, :show, course, quiz))
    end
  end

  defp load_resource(conn, _opts) do
    quiz = Exam.get_quiz!(conn.params["id"])
    assign(conn, :quiz, quiz)
  end

  defp load_questions(conn, _opts) do
    quiz = conn.assigns.quiz
    questions = Exam.list_questions(quiz)
    assign(conn, :questions, questions)
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"course_id" => conn.assigns.course.id})
  end
end
