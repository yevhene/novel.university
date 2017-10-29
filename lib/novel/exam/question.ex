defmodule Novel.Exam.Question do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Exam.Quiz
  alias Novel.Exam.Question

  schema "exam_questions" do
    field :title, :string
    field :details, :string

    belongs_to :quiz, Quiz

    timestamps(type: :utc_datetime)
  end

  def changeset(%Question{} = question, attrs) do
    question
    |> cast(attrs, [:title, :details, :quiz_id])
    |> validate_required([:title, :quiz_id])
    |> foreign_key_constraint(:quiz_id)
  end
end
