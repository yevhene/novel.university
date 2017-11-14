defmodule NovelWeb.Student.AttemptController do
  use NovelWeb, :controller

  alias Novel.Exam
  alias Novel.Exam.Attempt

  plug :load_parent
  plug :load_resource when action in [:show]
  plug :put_layout, "student.html"

  def new(conn, _params) do
    changeset = Exam.change_attempt(%Attempt{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, _params) do
    course = conn.assigns.course
    quiz = conn.assigns.quiz
    attempt_params = update_params(conn, %{})

    case Exam.create_attempt(attempt_params) do
      {:ok, attempt} ->
        conn
        |> redirect(to: student_course_quiz_attempt_path(
          conn, :show, course, quiz, attempt
        ))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    course = conn.assigns.course
    quiz = conn.assigns.quiz
    attempt = conn.assigns.attempt

    conn
    |> redirect(to: student_course_quiz_attempt_answer_path(
      conn, :show, course, quiz, attempt, Enum.at(attempt.answers, 0)
    ))
  end

  defp load_resource(conn, _opts) do
    attempt = Exam.get_attempt!(conn.params["id"])
    assign(conn, :attempt, attempt)
  end

  defp load_parent(conn, _opts) do
    quiz = Exam.get_quiz!(conn.params["quiz_id"])
    assign(conn, :quiz, quiz)
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"enrollment_id" => conn.assigns.enrollment.id})
    |> Map.merge(%{"quiz_id" => conn.assigns.quiz.id})
  end
end
