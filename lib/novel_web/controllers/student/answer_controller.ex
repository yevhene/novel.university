defmodule NovelWeb.Student.AnswerController do
  use NovelWeb, :controller

  alias Novel.Exam

  plug :load_resource
  plug :put_layout, "student.html"

  def show(conn, _params) do
    attempt = conn.assigns.attempt
    answer = conn.assigns.answer
    index = Enum.find_index(attempt.answers, fn a -> a.id == answer.id end)

    render(conn, "show.html", index: index)
  end

  defp load_resource(conn, _opts) do
    attempt = conn.assigns.attempt
    answer = Exam.get_answer!(attempt, conn.params["id"])

    assign(conn, :answer, answer)
  end
end
