defmodule Novel.Education.Group do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Education.Course
  alias Novel.Education.Group

  schema "groups" do
    field :name, :string
    field :invitation_code, :string

    belongs_to :course, Course

    timestamps(type: :utc_datetime)
  end

  def changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:name, :invitation_code, :course_id])
    |> validate_required([:name, :course_id])
    |> foreign_key_constraint(:course_id)
    |> unique_constraint(:name, name: :groups_course_id_name_index)
  end
end
