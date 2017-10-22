defmodule NovelWeb.Teacher.LabController do
  use NovelWeb, :controller

  alias Novel.University
  alias Novel.University.Lab

  plug :load_resource when action in [:show, :edit, :update, :delete]
  plug :put_layout, "teacher.html"

  def index(conn, _params) do
    course = conn.assigns.course
    labs = University.list_labs(course)
    render(conn, "index.html", labs: labs)
  end

  def new(conn, _params) do
    course = conn.assigns.course
    changeset = University.change_lab(%Lab{course_id: course.id})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"lab" => lab_params}) do
    course = conn.assigns.course
    lab_params = update_params(conn, lab_params)

    case University.create_lab(lab_params) do
      {:ok, _lab} ->
        conn
        |> put_flash(:info, gettext "Lab created successfully")
        |> redirect(to: teacher_course_lab_path(conn, :index, course))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, _params) do
    lab = conn.assigns.lab
    render(conn, "show.html", lab: lab)
  end

  def edit(conn, _params) do
    lab = conn.assigns.lab
    changeset = University.change_lab(lab)
    render(conn, "edit.html", lab: lab, changeset: changeset)
  end

  def update(conn, %{"lab" => lab_params}) do
    course = conn.assigns.course
    lab = conn.assigns.lab
    lab_params = update_params(conn, lab_params)

    case University.update_lab(lab, lab_params) do
      {:ok, lab} ->
        conn
        |> put_flash(:info, gettext "Lab updated successfully")
        |> redirect(to: teacher_course_lab_path(conn, :show, course, lab))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", lab: lab, changeset: changeset)
    end
  end

  def delete(conn, _params) do
    course = conn.assigns.course
    lab = conn.assigns.lab
    {:ok, _lab} = University.delete_lab(lab)

    conn
    |> put_flash(:info, gettext "Lab deleted successfully")
    |> redirect(to: teacher_course_lab_path(conn, :index, course))
  end

  defp load_resource(conn, _opts) do
    lab = University.get_lab!(conn.params["id"])
    assign(conn, :lab, lab)
  end

  defp update_params(conn, params) do
    params
    |> Map.merge(%{"course_id" => conn.assigns.course.id})
  end
end
