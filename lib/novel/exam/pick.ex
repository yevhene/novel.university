defmodule Novel.Exam.Pick do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Exam.Answer
  alias Novel.Exam.Option
  alias Novel.Exam.Pick

  schema "exam_picks" do
    field :is_picked, :boolean, default: false

    belongs_to :answer, Answer
    belongs_to :option, Option

    timestamps(type: :utc_datetime)
  end

  def changeset(%Pick{} = pick, attrs) do
    pick
    |> cast(attrs, [:is_picked, :answer_id, :option_id])
    |> validate_required([:answer_id, :option_id])
  end

  def update_changeset(%Pick{} = pick, attrs) do
    pick
    |> cast(attrs, [:is_picked])
    |> validate_required([:is_picked])
  end
end
