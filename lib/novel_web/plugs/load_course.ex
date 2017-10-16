defmodule NovelWeb.Plug.LoadCourse do
  import Plug.Conn, only: [assign: 3]

  alias Novel.University

  def init(opts), do: opts

  def call(conn, _opts) do
    course = University.get_course!(course_id(conn))
    assign(conn, :course, course)
  end

  defp course_id(conn) do
    conn.params["course_id"] || conn.params["id"]
  end
end
