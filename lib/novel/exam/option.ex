defmodule Novel.Exam.Option do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Exam.Option
  alias Novel.Exam.Question

  schema "exam_options" do
    field :text, :string
    field :is_correct, :boolean, default: false

    belongs_to :question, Question

    timestamps()
  end

  def changeset(%Option{} = option, attrs) do
    option
    |> cast(attrs, [:text, :is_correct, :question_id])
    |> validate_required([:text, :is_correct, :question_id])
    |> foreign_key_constraint(:question_id)
  end
end
