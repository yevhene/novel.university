defmodule Novel.University do
  import Ecto.Query, warn: false
  alias Novel.Repo

  alias Novel.University.Course
  alias Novel.University.Enrollment

  def list_courses do
    Course
    |> order_by(:started_at)
    |> Repo.all
    |> Repo.preload(:head)
  end

  def get_course!(id), do: Repo.get!(Course, id)

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

  def get_enrollment(course_id, user_id) do
    Enrollment
    |> Repo.get_by(course_id: course_id, user_id: user_id)
  end

  def get_enrollment!(course_id, user_id) do
    Enrollment
    |> Repo.get_by!(course_id: course_id, user_id: user_id)
  end

  def create_enrollment(attrs \\ %{}) do
    %Enrollment{}
    |> Enrollment.changeset(attrs)
    |> Repo.insert()
  end

  def delete_enrollment(%Enrollment{} = enrollment) do
    Repo.delete(enrollment)
  end

  def change_enrollment(%Enrollment{} = enrollment) do
    Enrollment.changeset(enrollment, %{})
  end
end
