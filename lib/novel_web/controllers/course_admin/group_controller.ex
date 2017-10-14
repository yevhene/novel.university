defmodule NovelWeb.CourseAdmin.GroupController do
  use NovelWeb, :controller

  alias Novel.Education
  alias Novel.Education.Group

  plug :load_and_authorize_course
  plug :authorize_resources when action in [:index, :new, :create]
  plug :load_and_authorize_resource when
    action in [:show, :edit, :update, :delete]
  plug :put_layout, "course_admin.html"

  def index(conn, _params) do
    course = conn.assigns.course
    groups = Education.list_groups(course)
    render(conn, "index.html", groups: groups)
  end

  def new(conn, _params) do
    course = conn.assigns.course
    changeset = Education.change_group(%Group{course_id: course.id})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"group" => group_params}) do
    course = conn.assigns.course
    group_params = update_params(conn, group_params)

    case Education.create_group(group_params) do
      {:ok, _group} ->
        conn
        |> put_flash(:info, "Group created successfully")
        |> redirect(to: course_admin_group_path(conn, :index, course))
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
    changeset = Education.change_group(group)
    render(conn, "edit.html", group: group, changeset: changeset)
  end

  def update(conn, %{"group" => group_params}) do
    course = conn.assigns.course
    group = conn.assigns.group
    group_params = update_params(conn, group_params)

    case Education.update_group(group, group_params) do
      {:ok, group} ->
        conn
        |> put_flash(:info, "Group updated successfully")
        |> redirect(to: course_admin_group_path(conn, :show, course, group))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", group: group, changeset: changeset)
    end
  end

  def delete(conn, _params) do
    course = conn.assigns.course
    group = conn.assigns.group
    {:ok, _group} = Education.delete_group(group)

    conn
    |> put_flash(:info, "Group deleted successfully")
    |> redirect(to: course_admin_group_path(conn, :index, course))
  end

  defp load_and_authorize_course(conn, _opts) do
    course = Education.get_course!(conn.params["course_id"])
    conn |> authorize!(:edit, course)
    assign(conn, :course, course)
  end

  defp authorize_resources(conn, _params) do
    conn |> authorize!(Group)
  end

  defp load_and_authorize_resource(conn, _opts) do
    group = Education.get_group!(conn.params["id"])
    conn |> authorize!(group)
    assign(conn, :group, group)
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"course_id" => conn.assigns.course.id})
  end
end
