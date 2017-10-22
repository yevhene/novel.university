defmodule Novel.University.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.University.Enrollment
  alias Novel.University.Lab
  alias Novel.University.Submission

  schema "university_submissions" do
    field :repository, :string

    belongs_to :enrollment, Enrollment
    belongs_to :lab, Lab

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Submission{} = submission, attrs) do
    submission
    |> cast(attrs, [:repository, :enrollment_id, :lab_id])
    |> validate_required([:repository, :enrollment_id, :lab_id])
  end
end
