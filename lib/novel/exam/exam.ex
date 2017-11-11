defmodule Novel.Exam do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias Novel.Repo

  alias Novel.Exam.Option
  alias Novel.Exam.Quiz
  alias Novel.Exam.Question
  alias Novel.University.Course

  def list_quizzes(%Course{id: course_id}) do
    Quiz
    |> where(course_id: ^course_id)
    |> order_by(:name)
    |> Repo.all
  end

  def list_active_quizzes(%Course{id: course_id}) do
    now = Ecto.DateTime.utc

    Quiz
    |> where(course_id: ^course_id)
    |> where([q], q.started_at <= type(^now, Ecto.DateTime))
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
    quiz
    |> change
    |> no_assoc_constraint(:questions)
    |> Repo.delete()
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
    question
    |> Repo.delete()
  end

  def change_question(%Question{} = question) do
    Question.changeset(question, %{})
  end

  def list_options(%Question{id: question_id}) do
    Option
    |> where(question_id: ^question_id)
    |> order_by(:inserted_at)
    |> Repo.all
  end

  def get_option!(id) do
    Option
    |> Repo.get!(id)
  end

  def create_option(attrs \\ %{}) do
    %Option{}
    |> Option.changeset(attrs)
    |> Repo.insert()
  end

  def update_option(%Option{} = option, attrs) do
    option
    |> Option.changeset(attrs)
    |> Repo.update()
  end

  def delete_option(%Option{} = option) do
    Repo.delete(option)
  end

  def change_option(%Option{} = option) do
    Option.changeset(option, %{})
  end
end
