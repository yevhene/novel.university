defmodule NovelWeb.Student.SubmissionController do
  use NovelWeb, :controller

  alias Novel.Assignment
  alias Novel.Assignment.Submission

  plug :load_parent
  plug :load_resource when action in [:delete]
  plug :put_layout, "student.html"

  def new(conn, _params) do
    changeset = Assignment.change_submission(%Submission{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"submission" => submission_params}) do
    course = conn.assigns.course
    lab = conn.assigns.lab
    submission_params = update_params(conn, submission_params)

    case Assignment.create_submission(submission_params) do
      {:ok, _submission} ->
        conn
        |> put_flash(:info, gettext "Submission created successfully")
        |> redirect(to: student_course_lab_path(conn, :show, course, lab))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def delete(conn, _params) do
    course = conn.assigns.course
    lab = conn.assigns.lab
    submission = conn.assigns.submission

    if submission.is_approved == nil do
      {:ok, _submission} = Assignment.delete_submission(submission)

      conn
      |> put_flash(:info, gettext "Submission deleted successfully")
      |> redirect(to: student_course_lab_path(conn, :show, course, lab))
    else
      conn
      |> put_flash(:error, gettext "Submission can't be deleted")
      |> redirect(to: student_course_lab_path(conn, :show, course, lab))
    end
  end

  defp load_resource(conn, _opts) do
    enrollment = conn.assigns.enrollment
    submission = Assignment.get_submission!(enrollment, conn.params["id"])
    assign(conn, :submission, submission)
  end

  defp load_parent(conn, _opts) do
    lab = Assignment.get_lab!(conn.params["lab_id"])
    assign(conn, :lab, lab)
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"lab_id" => conn.assigns.lab.id})
    |> Map.merge(%{"enrollment_id" => conn.assigns.enrollment.id})
  end
end
