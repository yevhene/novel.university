defmodule NovelWeb.Teacher.OptionController do
  use NovelWeb, :controller

  alias Novel.Exam
  alias Novel.Exam.Option

  plug :load_parent
  plug :load_resource when action in [:show, :edit, :update, :delete]
  plug :put_layout, "teacher.html"

  def new(conn, _params) do
    changeset = Exam.change_option(%Option{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"option" => option_params}) do
    course = conn.assigns.course
    quiz = conn.assigns.quiz
    question = conn.assigns.question
    option_params = update_params(conn, option_params)

    case Exam.create_option(option_params) do
      {:ok, _option} ->
        conn
        |> put_flash(:info, gettext "Option created successfully")
        |> redirect(to: teacher_course_quiz_question_path(
          conn, :show, course, quiz, question
        ))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    option = conn.assigns.option
    render(conn, "show.html", option: option)
  end

  def edit(conn, _params) do
    option = conn.assigns.option
    changeset = Exam.change_option(option)
    render(conn, "edit.html", option: option, changeset: changeset)
  end

  def update(conn, %{"option" => option_params}) do
    course = conn.assigns.course
    quiz = conn.assigns.quiz
    option = conn.assigns.option
    option_params = update_params(conn, option_params)

    case Exam.update_option(option, option_params) do
      {:ok, option} ->
        conn
        |> put_flash(:info, gettext "Option updated successfully")
        |> redirect(to: teacher_course_quiz_question_option_path(
          conn, :show, course, quiz, option
        ))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", option: option, changeset: changeset)
    end
  end

  def delete(conn, _params) do
    course = conn.assigns.course
    quiz = conn.assigns.quiz
    question = conn.assigns.question
    option = conn.assigns.option
    {:ok, _option} = Exam.delete_option(option)

    conn
    |> put_flash(:info, gettext "Option deleted successfully")
    |> redirect(to: teacher_course_quiz_question_path(
      conn, :show, course, quiz, question
    ))
  end

  defp load_resource(conn, _opts) do
    option = Exam.get_option!(conn.params["id"])
    assign(conn, :option, option)
  end

  defp load_parent(conn, _opts) do
    quiz = Exam.get_quiz!(conn.params["quiz_id"])
    question = Exam.get_question!(conn.params["question_id"])

    conn
    |> assign(:quiz, quiz)
    |> assign(:question, question)
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"question_id" => conn.assigns.question.id})
  end
end
