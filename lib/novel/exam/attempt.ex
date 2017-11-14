defmodule Novel.Exam.Attempt do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Exam.Answer
  alias Novel.Exam.Attempt
  alias Novel.Exam.Quiz
  alias Novel.Exam.Score
  alias Novel.University.Enrollment

  schema "exam_attempts" do
    belongs_to :enrollment, Enrollment
    belongs_to :quiz, Quiz

    has_many :answers, Answer
    has_one :score, Score

    timestamps(type: :utc_datetime)
  end

  def changeset(%Attempt{} = attempt, attrs) do
    attempt
    |> cast(attrs, [:enrollment_id, :quiz_id])
    |> validate_required([:enrollment_id, :quiz_id])
    |> foreign_key_constraint(:enrollment_id)
    |> foreign_key_constraint(:quiz_id)
  end
end
