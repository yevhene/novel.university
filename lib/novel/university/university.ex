defmodule Novel.University do
  import Ecto.Query, warn: false
  alias Novel.Repo

  alias Novel.Account.User
  alias Novel.Assignment.Lab
  alias Novel.Assignment.Submission
  alias Novel.University.Course
  alias Novel.University.Enrollment
  alias Novel.University.Group

  def list_courses do
    Course
    |> order_by(:started_at)
    |> Repo.all
    |> Repo.preload(:head)
  end

  def get_course!(id) do
    Course
    |> Repo.get!(id)
    |> Repo.preload(:head)
  end

  def create_course(attrs \\ %{}) do
    %Course{}
    |> Course.changeset(attrs)
    |> Repo.insert()
  end

  def update_course(%Course{} = course, attrs) do
    course
    |> Course.changeset(attrs)
    |> Repo.update()
  end

  def delete_course(%Course{} = course) do
    Repo.delete(course)
  end

  def change_course(%Course{} = course) do
    Course.changeset(course, %{})
  end

  def update_course_repository(%Course{} = course, attrs) do
    course
    |> Course.repository_changeset(attrs)
    |> Repo.update()
  end

  def delete_course_repository(%Course{} = course) do
    course
    |> Course.repository_changeset(%{repository: nil})
    |> Repo.update()
  end

  def change_course_repository(%Course{} = course) do
    Course.repository_changeset(course, %{})
  end

  def list_enrollments(%Course{} = course) do
    Enrollment
    |> where(course_id: ^course.id)
    |> order_by(desc: :inserted_at)
    |> Repo.all
    |> Repo.preload(:user)
    |> Repo.preload(:group)
  end

  def new_enrollments_count(%Course{} = course) do
    Enrollment
    |> where(course_id: ^course.id)
    |> where([e], is_nil(e.group_id))
    |> Repo.aggregate(:count, :id)
  end

  def get_enrollment!(id) do
    Enrollment
    |> Repo.get!(id)
    |> Repo.preload(:user)
    |> Repo.preload(:course)
    |> Repo.preload(:group)
  end

  def get_user_enrollment(%User{} = user, %Course{} = course) do
    Enrollment
    |> Repo.get_by(course_id: course.id, user_id: user.id)
    |> Repo.preload(:group)
  end

  def get_user_enrollment(nil, %Course{}), do: nil

  def get_user_enrollment!(%User{} = user, %Course{} = course) do
    Enrollment
    |> Repo.get_by!(course_id: course.id, user_id: user.id)
    |> Repo.preload(:group)
  end

  def create_enrollment(attrs \\ %{}) do
    %Enrollment{}
    |> Enrollment.changeset(attrs)
    |> Repo.insert()
  end

  def update_enrollment_group(%Enrollment{} = enrollment, attrs) do
    enrollment
    |> Enrollment.group_changeset(attrs)
    |> Repo.update()
  end

  def delete_enrollment(%Enrollment{} = enrollment) do
    Repo.delete(enrollment)
  end

  def change_enrollment(%Enrollment{} = enrollment) do
    Enrollment.changeset(enrollment, %{})
  end

  def list_groups(%{id: course_id}) do
    Group
    |> where(course_id: ^course_id)
    |> order_by(:name)
    |> Repo.all
  end

  def get_group!(id) do
    Group
    |> Repo.get!(id)
    |> Repo.preload(:course)
  end

  def create_group(attrs \\ %{}) do
    %Group{}
    |> Group.changeset(attrs)
    |> Repo.insert()
  end

  def update_group(%Group{} = group, attrs) do
    group
    |> Group.changeset(attrs)
    |> Repo.update()
  end

  def delete_group(%Group{} = group) do
    Repo.delete(group)
  end

  def change_group(%Group{} = group) do
    Group.changeset(group, %{})
  end

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
