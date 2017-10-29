defmodule Novel.Exam do
  import Ecto.Query, warn: false
  alias Novel.Repo

  alias Novel.Exam.Quiz

  def list_quizzes(%{id: course_id}) do
    Quiz
    |> where(course_id: ^course_id)
    |> order_by(:name)
    |> Repo.all
  end

  def get_quiz!(id) do
    Quiz
    |> Repo.get!(id)
    |> Repo.preload(:course)
  end

  def create_quiz(attrs \\ %{}) do
    %Quiz{}
    |> Quiz.changeset(attrs)
    |> Repo.insert()
  end

  def update_quiz(%Quiz{} = quiz, attrs) do
    quiz
    |> Quiz.changeset(attrs)
    |> Repo.update()
  end

  def delete_quiz(%Quiz{} = quiz) do
    Repo.delete(quiz)
  end

  def change_quiz(%Quiz{} = quiz) do
    Quiz.changeset(quiz, %{})
  end
end
