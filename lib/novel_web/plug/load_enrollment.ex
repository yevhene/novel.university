defmodule NovelWeb.Plug.LoadEnrollment do
  import Plug.Conn, only: [assign: 3]

  alias Novel.University

  def init(opts), do: opts

  def call(conn, _opts) do
    user = conn.assigns.current_user
    course = conn.assigns.course
    enrollment = University.get_user_enrollment(user, course)

    assign(conn, :enrollment, enrollment)
  end
end
