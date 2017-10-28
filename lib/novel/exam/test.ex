defmodule Novel.Exam.Test do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Exam.Test
  alias Novel.University.Course

  schema "exam_tests" do
    field :name, :string
    field :description, :string

    field :sample_size, :integer

    belongs_to :course_id, Course

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Test{} = test, attrs) do
    test
    |> cast(attrs, [:name, :description, :sample_size, :course_id])
    |> validate_required([:name, :sample_size, :course_id])
    |> foreign_key_constraint(:course_id)
    |> unique_constraint(:name, name: :exam_tests_course_id_name_index)
  end
end
