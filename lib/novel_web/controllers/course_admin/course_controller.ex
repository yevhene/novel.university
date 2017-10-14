defmodule NovelWeb.CourseAdmin.CourseController do
  use NovelWeb, :controller

  alias Novel.Education

  plug :load_and_authorize_course when
    action in [:show, :edit, :update, :delete]
  plug :put_layout, "course_admin.html"

  def show(conn, _params) do
    course = conn.assigns.course
    render(conn, "show.html", course: course)
  end

  def edit(conn, _params) do
    course = conn.assigns.course
    changeset = Education.change_course(course)
    render(conn, "edit.html", course: conn.assigns.course, changeset: changeset)
  end

  def update(conn, %{"course" => course_params}) do
    course = conn.assigns.course
    course_params = update_params(conn, course_params)

    case Education.update_course(course, course_params) do
      {:ok, course} ->
        conn
        |> put_flash(:info, "Course updated successfully")
        |> redirect(to: course_admin_course_path(conn, :show, course))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", course: course, changeset: changeset)
    end
  end

  def delete(conn, _params) do
    course = conn.assigns.course
    {:ok, _course} = Education.delete_course(course)

    conn
    |> put_flash(:info, "Course deleted successfully")
    |> redirect(to: course_path(conn, :index))
  end

  defp load_and_authorize_course(conn, _opts) do
    course = Education.get_course!(conn.params["course_id"])
    conn |> authorize!(:edit, course)
    assign(conn, :course, course)
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"user_id" => conn.assigns.current_user.id})
  end
end
