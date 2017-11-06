defmodule NovelWeb.Teacher.GroupController do
  use NovelWeb, :controller

  alias Novel.University
  alias Novel.University.Group

  plug :load_resource when action in [:show, :edit, :update, :delete]
  plug :put_layout, "teacher.html"

  def index(conn, _params) do
    course = conn.assigns.course
    groups = University.list_groups(course)
    render(conn, "index.html", groups: groups)
  end

  def new(conn, _params) do
    changeset = University.change_group(%Group{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"group" => group_params}) do
    course = conn.assigns.course
    group_params = update_params(conn, group_params)

    case University.create_group(group_params) do
      {:ok, _group} ->
        conn
        |> put_flash(:info, gettext "Group created successfully")
        |> redirect(to: teacher_course_group_path(conn, :index, course))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    group = conn.assigns.group
    render(conn, "show.html", group: group)
  end

  def edit(conn, _params) do
    group = conn.assigns.group
    changeset = University.change_group(group)
    render(conn, "edit.html", group: group, changeset: changeset)
  end

  def update(conn, %{"group" => group_params}) do
    course = conn.assigns.course
    group = conn.assigns.group
    group_params = update_params(conn, group_params)

    case University.update_group(group, group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:info, gettext "Group updated successfully")
        |> redirect(to: teacher_course_group_path(conn, :show, course, group))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", group: group, changeset: changeset)
    end
  end

  def delete(conn, _params) do
    course = conn.assigns.course
    group = conn.assigns.group

    case University.delete_group(group) do
      {:ok, _group} ->
        conn
        |> put_flash(:info, gettext "Group deleted successfully")
        |> redirect(to: teacher_course_group_path(conn, :index, course))
      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> put_flash(:error, gettext "Group can't be deleted")
        |> redirect(to: teacher_course_group_path(conn, :show, course, group))
    end
  end

  defp load_resource(conn, _opts) do
    group = University.get_group!(conn.params["id"])
    assign(conn, :group, group)
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"course_id" => conn.assigns.course.id})
  end
end
