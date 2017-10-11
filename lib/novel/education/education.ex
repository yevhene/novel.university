defmodule Novel.Education do
  import Ecto.Query, warn: false
  alias Novel.Repo

  alias Novel.Education.Course

  def list_courses do
    Course
    |> Repo.all
    |> Repo.preload(:user)
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
end
