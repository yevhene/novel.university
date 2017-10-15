defmodule Novel.University do
  import Ecto.Query, warn: false
  alias Novel.Repo
  alias Novel.Util.Token

  alias Novel.University.Course
  alias Novel.University.Group
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

  def list_groups(course) do
    Group
    |> where(course_id: ^course.id)
    |> order_by(:name)
    |> Repo.all
  end

  def get_group!(id) do
    Group
    |> Repo.get!(id)
    |> Repo.preload(:course)
  end

  def create_group(attrs \\ %{}) do
    attrs = attrs
    |> Map.put("invitation_code", Token.generate)

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

  def get_group_by_invitation_code(invitation_code) do
    Group
    |> Repo.get_by(invitation_code: invitation_code)
    |> Repo.preload(course: :user)
  end

  def create_enrollment(attrs \\ %{}) do
    invitation_code = Map.get(attrs, "invitation_code")
    group = Group |> Repo.get_by(invitation_code: invitation_code)

    attrs = attrs
    |> Map.delete("invitation_code")
    |> Map.put("group_id", group && group.id)

    %Enrollment{}
    |> Enrollment.changeset(attrs)
    |> Repo.insert()
  end

  def change_enrollment(%Enrollment{} = enrollment) do
    Enrollment.changeset(enrollment, %{})
  end
end
