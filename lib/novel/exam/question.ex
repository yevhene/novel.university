defmodule Novel.Exam.Question do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Exam.Quiz
  alias Novel.Exam.Question

  schema "exam_questions" do
    field :text, :string

    field :tags, {:array, :string}, default: []
    field :options, {:array, :string}
    field :correct_keys, {:array, :integer}

    field :is_deprecated, :boolean, default: false

    belongs_to :quiz, Quiz

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Question{} = question, attrs) do
    question
    |> cast(attrs, [
      :text, :tags, :options, :correct_keys, :is_deprecated, :quiz_id
    ])
    |> validate_required([:text, :options, :correct_keys, :quiz_id])
    |> foreign_key_constraint(:quiz_id)
  end
end
