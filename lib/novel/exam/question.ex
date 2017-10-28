defmodule Novel.Exam.Question do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Exam.Test
  alias Novel.Exam.Question

  schema "exam_questions" do
    field :code, :string
    field :text, :string

    field :tags, {:array, :string}, default: []
    field :options, {:array, :string}
    field :correct_keys, {:array, :integer}

    field :is_deprecated, :boolean, default: false

    belongs_to :test, Test

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Question{} = question, attrs) do
    question
    |> cast(attrs, [
      :code, :text, :tags, :options, :correct_keys, :is_deprecated, :test_id
    ])
    |> validate_required([:code, :text, :options, :correct_keys, :test_id])
    |> foreign_key_constraint(:test_id)
    |> unique_constraint(:name, name: :exam_questions_test_id_code_index)
  end
end
