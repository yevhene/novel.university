defmodule Novel.Exam.Result do
  use Ecto.Schema

  alias Novel.Exam.Quiz
  alias Novel.University.Enrollment

  @primary_key false
  schema "exam_results" do
    field :score, :float
    field :is_passed, :boolean

    belongs_to :quiz, Quiz
    belongs_to :enrollment, Enrollment
  end
end
