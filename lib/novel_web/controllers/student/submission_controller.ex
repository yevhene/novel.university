defmodule NovelWeb.Student.SubmissionController do
  use NovelWeb, :controller

  alias Novel.University
  alias Novel.University.Submission

  plug :load_lab
  plug :put_layout, "student.html"

  def new(conn, _params) do
    changeset = University.change_submission(%Submission{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"submission" => submission_params}) do
    course = conn.assigns.course
    lab = conn.assigns.lab
    submission_params = update_params(conn, submission_params)

    case University.create_submission(submission_params) do
      {:ok, _submission} ->
        conn
        |> put_flash(:info, gettext "Submission created successfully")
        |> redirect(to: student_course_lab_path(conn, :show, course, lab))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  defp load_lab(conn, _opts) do
    lab = University.get_lab!(conn.params["lab_id"])
    assign(conn, :lab, lab)
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"lab_id" => conn.assigns.lab.id})
    |> Map.merge(%{"enrollment_id" => conn.assigns.enrollment.id})
  end
end
