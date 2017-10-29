defmodule Novel.Exam do
  import Ecto.Query, warn: false
  alias Novel.Repo

  alias Novel.Exam.Quiz
  alias Novel.Exam.Question
  alias Novel.University.Course

  def list_quizzes(%Course{id: course_id}) do
    Quiz
    |> where(course_id: ^course_id)
    |> order_by(:name)
    |> Repo.all
  end

  def get_quiz!(id) do
    Quiz
    |> Repo.get!(id)
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

  def list_questions(%Quiz{id: quiz_id}) do
    Question
    |> where(quiz_id: ^quiz_id)
    |> order_by(:inserted_at)
    |> Repo.all
  end

  def get_question!(id) do
    Question
    |> Repo.get!(id)
  end

  def create_question(attrs \\ %{}) do
    %Question{}
    |> Question.changeset(attrs)
    |> Repo.insert()
  end

  def update_question(%Question{} = question, attrs) do
    question
    |> Question.changeset(attrs)
    |> Repo.update()
  end

  def delete_question(%Question{} = question) do
    Repo.delete(question)
  end

  def change_question(%Question{} = question) do
    Question.changeset(question, %{})
  end
end
