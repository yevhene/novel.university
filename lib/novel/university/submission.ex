defmodule Novel.University.Submission do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.University.Enrollment
  alias Novel.University.Lab
  alias Novel.University.Submission

  schema "university_submissions" do
    field :repo, :string

    belongs_to :enrollment, Enrollment
    belongs_to :lab, Lab

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Submission{} = submission, attrs) do
    submission
    |> cast(attrs, [:repo, :enrollment_id, :lab_id])
    |> validate_required([:repo, :enrollment_id, :lab_id])
  end
end
