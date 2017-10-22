defmodule Novel.Assignment do
  import Ecto.Query, warn: false
  alias Novel.Repo

  alias Novel.Assignment.Lab
  alias Novel.Assignment.Submission
  alias Novel.University.Course
  alias Novel.University.Enrollment

  def list_labs(%Course{id: course_id}) do
    Lab
    |> where(course_id: ^course_id)
    |> order_by(:title)
    |> Repo.all
  end

  def get_lab!(id) do
    Lab
    |> Repo.get!(id)
    |> Repo.preload(:course)
  end

  def create_lab(attrs \\ %{}) do
    %Lab{}
    |> Lab.changeset(attrs)
    |> Repo.insert()
  end

  def update_lab(%Lab{} = lab, attrs) do
    lab
    |> Lab.changeset(attrs)
    |> Repo.update()
  end

  def delete_lab(%Lab{} = lab) do
    Repo.delete(lab)
  end

  def change_lab(%Lab{} = lab) do
    Lab.changeset(lab, %{})
  end

  def list_submissions(%Enrollment{id: enrollment_id}, %Lab{id: lab_id}) do
    Submission
    |> where(enrollment_id: ^enrollment_id)
    |> where(lab_id: ^lab_id)
    |> order_by(desc: :inserted_at)
    |> Repo.all
  end

  def create_submission(attrs \\ %{}) do
    %Submission{}
    |> Submission.changeset(attrs)
    |> Repo.insert()
  end

  def change_submission(%Submission{} = submission) do
    Submission.changeset(submission, %{})
  end
end
