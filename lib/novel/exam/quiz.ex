defmodule Novel.Exam.Quiz do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Exam.Quiz
  alias Novel.University.Course

  schema "exam_quizzes" do
    field :name, :string
    field :description, :string

    field :sample_size, :integer

    belongs_to :course, Course

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Quiz{} = quiz, attrs) do
    quiz
    |> cast(attrs, [:name, :description, :sample_size, :course_id])
    |> validate_required([:name, :course_id])
    |> foreign_key_constraint(:course_id)
    |> unique_constraint(:name, name: :exam_quizzes_course_id_name_index)
  end
end
