defmodule Novel.Assignment do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias Novel.Repo

  alias Novel.Assignment.Lab
  alias Novel.Assignment.Result
  alias Novel.Assignment.Submission
  alias Novel.University.Course
  alias Novel.University.Enrollment

  def list_labs(%Course{id: course_id}) do
    Lab
    |> where(course_id: ^course_id)
    |> order_by(asc: :id)
    |> Repo.all
  end

  def list_labs(%Course{id: course_id}, %Enrollment{id: enrollment_id}) do
    Lab
    |> where(course_id: ^course_id)
    |> order_by(asc: :id)
    |> Repo.all
    |> Repo.preload([
      results: from(r in Result, where: r.enrollment_id == ^enrollment_id)
    ])
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
    lab
    |> change
    |> no_assoc_constraint(:submissions)
    |> Repo.delete()
  end

  def change_lab(%Lab{} = lab) do
    Lab.changeset(lab, %{})
  end

  def list_submissions(%Course{} = course) do
    Submission
    |> join(
      :inner, [s], l in Lab, s.lab_id == l.id and l.course_id == ^course.id
    )
    |> order_by(desc: :inserted_at)
    |> Repo.all
    |> Repo.preload([:lab, enrollment: [:user, :group]])
  end

  def list_submissions(%Enrollment{id: enrollment_id}, %Lab{id: lab_id}) do
    Submission
    |> where(enrollment_id: ^enrollment_id)
    |> where(lab_id: ^lab_id)
    |> order_by(desc: :inserted_at)
    |> Repo.all
  end

  def new_submissions_count(%Course{} = course) do
    Enrollment
    Submission
    |> join(
      :inner, [s], l in Lab, s.lab_id == l.id and l.course_id == ^course.id
    )
    |> where([s], is_nil(s.is_approved))
    |> Repo.aggregate(:count, :id)
  end

  def get_submission!(id) do
    Submission
    |> Repo.get!(id)
    |> Repo.preload([:lab, enrollment: [:user, :group]])
  end

  def get_submission!(%Enrollment{} = enrollment, id) do
    Submission
    |> where(enrollment_id: ^enrollment.id)
    |> where(id: ^id)
    |> limit(1)
    |> Repo.one()
    |> Repo.preload([:lab, enrollment: [:user, :group]])
  end

  def create_submission(attrs \\ %{}) do
    %Submission{}
    |> Submission.changeset(attrs)
    |> Repo.insert()
  end

  def update_submission(%Submission{} = submission, attrs) do
    submission
    |> Submission.update_changeset(attrs)
    |> Repo.update()
  end

  def delete_submission(%Submission{} = submission) do
    Repo.delete(submission)
  end

  def change_submission(%Submission{} = submission) do
    Submission.changeset(submission, %{})
  end
end
