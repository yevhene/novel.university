defmodule Novel.Exam.Answer do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Exam.Answer
  alias Novel.Exam.Attempt
  alias Novel.Exam.Question

  schema "exam_answers" do
    belongs_to :attempt, Attempt
    belongs_to :question, Question

    timestamps(type: :utc_datetime)
  end

  def changeset(%Answer{} = answer, attrs) do
    answer
    |> cast(attrs, [:attempt_id, :question_id])
    |> validate_required([:attempt_id, :question_id])
    |> foreign_key_constraint(:attempt_id)
    |> foreign_key_constraint(:question_id)
    |> unique_constraint(:question_id,
      name: :exam_answers_question_id_attempt_id_index
    )
  end
end
