defmodule Novel.Assignment.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.University.Enrollment
  alias Novel.Assignment.Lab
  alias Novel.Assignment.Submission

  schema "assignment_submissions" do
    field :repository, :string
    field :is_approved, :boolean

    belongs_to :enrollment, Enrollment
    belongs_to :lab, Lab

    timestamps(type: :utc_datetime)
  end

  def changeset(%Submission{} = submission, attrs) do
    submission
    |> cast(attrs, [:repository, :enrollment_id, :lab_id])
    |> validate_required([:repository, :enrollment_id, :lab_id])
  end

  def approvement_changeset(%Submission{} = submission, attrs) do
    submission
    |> cast(attrs, [:is_approved])
  end
end
