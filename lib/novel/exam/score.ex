defmodule Novel.Exam.Score do
  use Ecto.Schema

  alias Novel.Exam.Attempt

  @primary_key false
  schema "exam_scores" do
    field :value, :float
    field :is_passed, :boolean

    belongs_to :attempt, Attempt
  end
end
