defmodule Novel.Exam.Quiz do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Exam.Attempt
  alias Novel.Exam.Quiz
  alias Novel.Exam.Question
  alias Novel.University.Course

  schema "exam_quizzes" do
    field :name, :string
    field :description, :string

    field :sample_size, :integer
    field :duration, :integer
    field :threshold, :float

    field :started_at, :utc_datetime

    belongs_to :course, Course

    has_many :questions, Question
    has_many :attempts, Attempt

    timestamps(type: :utc_datetime)
  end

  def changeset(%Quiz{} = quiz, attrs) do
    quiz
    |> cast(attrs, [
      :name, :description, :sample_size, :duration, :threshold,
      :started_at, :course_id
    ])
    |> validate_required([:name, :started_at, :course_id])
    |> validate_number(:threshold,
      greater_than_or_equal_to: 0, less_than_or_equal_to: 1
    )
    |> foreign_key_constraint(:course_id)
    |> unique_constraint(:name, name: :exam_quizzes_course_id_name_index)
  end
end
