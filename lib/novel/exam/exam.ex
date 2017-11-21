defmodule Novel.Exam do
  import Ecto.Query, warn: false
  import Ecto.Changeset
  alias Novel.Repo

  alias Novel.Exam.Answer
  alias Novel.Exam.Attempt
  alias Novel.Exam.Option
  alias Novel.Exam.Pick
  alias Novel.Exam.Quiz
  alias Novel.Exam.Question
  alias Novel.University.Course
  alias Novel.University.Enrollment

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
    |> Repo.preload(:questions)
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

  def list_attempts(%Course{id: course_id}) do
    Repo.all from a in Attempt,
      join: q in Quiz, on: q.id == a.quiz_id,
      where: q.course_id == ^course_id,
      order_by: [desc: :inserted_at],
      preload: [:quiz, :score, enrollment: :user]
  end

  def list_attempts(%Enrollment{id: enrollment_id}, %Quiz{id: quiz_id}) do
    Attempt
    |> where(enrollment_id: ^enrollment_id)
    |> where(quiz_id: ^quiz_id)
    |> order_by(desc: :inserted_at)
    |> Repo.all
    |> Repo.preload([:quiz, :score])
  end

  def get_attempt!(id) do
    Attempt
    |> Repo.get!(id)
    |> Repo.preload(:quiz)
    |> Repo.preload(answers: from(
      a in Answer, order_by: a.inserted_at
    ))
  end

  def get_attempt!(%Enrollment{} = enrollment, id) do
    Attempt
    |> where(enrollment_id: ^enrollment.id)
    |> where(id: ^id)
    |> limit(1)
    |> Repo.one()
    |> Repo.preload(:quiz)
    |> Repo.preload(answers: from(
      a in Answer, order_by: a.inserted_at
    ))
  end

  def create_attempt(attrs \\ %{}) do
    %Attempt{}
    |> Attempt.changeset(attrs)
    |> Repo.insert()
    |> create_attempt_answers()
  end

  def change_attempt(%Attempt{} = attempt) do
    Attempt.changeset(attempt, %{})
  end

  def is_active?(%Attempt{} = attempt) do
    time_left(attempt) > 0
  end

  def time_left(%Attempt{} = attempt) do
    inserted_at = DateTime.to_unix(attempt.inserted_at)
    duration_ago = inserted_at + attempt.quiz.duration * 60
    now = DateTime.to_unix DateTime.utc_now
    duration_ago - now
  end

  def is_successful?(%Attempt{} = attempt) do
    attempt.score.value >= attempt.quiz.threshold
  end

  def is_successful?(%Enrollment{} = enrollment, %Quiz{} = quiz) do
    student_attempts = enrollment
      |> list_attempts(quiz)
      |> Enum.filter(&(not is_active?(&1)))

    cond do
      length(student_attempts) == 0 ->
        nil
      student_attempts |> Enum.any?(&(is_successful?(&1))) ->
        true
      true ->
        false
    end
  end

  def get_answer!(%Attempt{} = attempt, id) do
    Answer
    |> where(attempt_id: ^attempt.id)
    |> where(id: ^id)
    |> limit(1)
    |> Repo.one()
    |> Repo.preload(:question)
    |> Repo.preload(picks: from(
      p in Pick, order_by: p.inserted_at, preload: :option
    ))
  end

  def get_pick!(%Answer{} = answer, id) do
    Pick
    |> where(answer_id: ^answer.id)
    |> where(id: ^id)
    |> limit(1)
    |> Repo.one()
    |> Repo.preload(:option)
  end

  def update_pick(%Pick{} = pick, attrs) do
    pick
    |> Pick.changeset(attrs)
    |> Repo.update()
  end

  def change_pick(%Pick{} = pick) do
    Pick.update_changeset(pick, %{})
  end

  defp create_answer(attrs) do
    %Answer{}
    |> Answer.changeset(attrs)
    |> Repo.insert()
  end

  defp create_pick(attrs) do
    %Pick{}
    |> Pick.changeset(attrs)
    |> Repo.insert()
  end

  defp create_attempt_answers({:ok, %Attempt{} = attempt}) do
    quiz = get_quiz!(attempt.quiz_id)
    total = length(quiz.questions)

    answers = 0..(total - 1)
      |> Enum.to_list()
      |> Enum.shuffle()
      |> Enum.take(quiz.sample_size || total)
      |> Enum.map(fn index ->
        question = quiz.questions |> Enum.at(index)
        {:ok, answer} = %{
          attempt_id: attempt.id, question_id: question.id
        }
        |> create_answer()
        |> create_answer_picks()

        answer
      end)

    attempt = %Attempt{attempt | answers: answers}

    {:ok, attempt}
  end

  defp create_answer_picks({:ok, answer}) do
    answer = answer |> Repo.preload(question: :options)

    answer.question.options
    |> Enum.shuffle()
    |> Enum.each(fn option ->
      {:ok, _pick} = create_pick(%{
        answer_id: answer.id, option_id: option.id
      })
    end)

    {:ok, answer}
  end
end
