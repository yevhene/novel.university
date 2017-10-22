defmodule NovelWeb.Teacher.SubmissionController do
  use NovelWeb, :controller

  alias Novel.Assignment

  plug :load_resource when action in [:show, :edit, :update]
  plug :put_layout, "teacher.html"

  def index(conn, _params) do
    course = conn.assigns.course
    submissions = Assignment.list_submissions(course)
    render(conn, "index.html", submissions: submissions)
  end

  def show(conn, _params) do
    submission = conn.assigns.submission
    render(conn, "show.html", submission: submission)
  end

  def edit(conn, _params) do
    submission = conn.assigns.submission
    changeset = Assignment.change_submission(submission)
    render(conn, "edit.html", submission: submission, changeset: changeset)
  end

  def update(conn, %{"submission" => submission_params}) do
    course = conn.assigns.course
    submission = conn.assigns.submission

    case Assignment.update_submission(submission, submission_params) do
      {:ok, submission} ->
        conn
        |> put_flash(:info, gettext "Submission updated successfully")
        |> redirect(
          to: teacher_course_submission_path(conn, :show, course, submission)
        )
      {:error, %Ecto.Changeset{} = changeset} ->
        render(
          conn, "edit.html", submission: submission, changeset: changeset
        )
    end
  end

  defp load_resource(conn, _opts) do
    submission = Assignment.get_submission!(conn.params["id"])
    assign(conn, :submission, submission)
  end
end
