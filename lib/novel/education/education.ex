defmodule Novel.Education do
  import Ecto.Query, warn: false
  alias Novel.Repo

  alias Novel.Education.Course
  alias Novel.Education.Group

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

  def list_groups(course) do
    Group
    |> where(course_id: ^course.id)
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
end
