defmodule NovelWeb.Teacher.QuestionController do
  use NovelWeb, :controller

  alias Novel.Exam
  alias Novel.Exam.Question

  plug :load_parent
  plug :load_resource when action in [:show, :edit, :update, :delete]
  plug :load_options when action in [:show]
  plug :put_layout, "teacher.html"

  def new(conn, _params) do
    changeset = Exam.change_question(%Question{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"question" => question_params}) do
    course = conn.assigns.course
    quiz = conn.assigns.quiz
    question_params = update_params(conn, question_params)

    case Exam.create_question(question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, gettext "Question created successfully")
        |> redirect(to: teacher_course_quiz_question_path(
          conn, :show, course, quiz, question
        ))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    question = conn.assigns.question
    render(conn, "show.html", question: question)
  end

  def edit(conn, _params) do
    question = conn.assigns.question
    changeset = Exam.change_question(question)
    render(conn, "edit.html", question: question, changeset: changeset)
  end

  def update(conn, %{"question" => question_params}) do
    course = conn.assigns.course
    quiz = conn.assigns.quiz
    question = conn.assigns.question
    question_params = update_params(conn, question_params)

    case Exam.update_question(question, question_params) do
      {:ok, question} ->
        conn
        |> put_flash(:info, gettext "Question updated successfully")
        |> redirect(to: teacher_course_quiz_question_path(
          conn, :show, course, quiz, question
        ))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", question: question, changeset: changeset)
    end
  end

  def delete(conn, _params) do
    course = conn.assigns.course
    quiz = conn.assigns.quiz
    question = conn.assigns.question

    case Exam.delete_question(question) do
      {:ok, _question} ->
        conn
        |> put_flash(:info, gettext "Question deleted successfully")
        |> redirect(to: teacher_course_quiz_path(conn, :show, course, quiz))
      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(:error, gettext "Question can't be deleted")
        |> redirect(to: teacher_course_quiz_question_path(
          conn, :show, course, quiz, question
        ))
    end
  end

  defp load_resource(conn, _opts) do
    question = Exam.get_question!(conn.params["id"])
    assign(conn, :question, question)
  end

  defp load_parent(conn, _opts) do
    quiz = Exam.get_quiz!(conn.params["quiz_id"])
    assign(conn, :quiz, quiz)
  end

  defp load_options(conn, _opts) do
    question = conn.assigns.question
    options = Exam.list_options(question)
    assign(conn, :options, options)
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"quiz_id" => conn.assigns.quiz.id})
  end
end
