defmodule Novel.University.Group do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.University.Course
  alias Novel.University.Enrollment
  alias Novel.University.Group

  schema "university_groups" do
    field :name, :string

    belongs_to :course, Course
    has_many :enrollments, Enrollment

    timestamps(type: :utc_datetime)
  end

  def changeset(%Group{} = group, attrs) do
    group
    |> cast(attrs, [:name, :course_id])
    |> validate_required([:name, :course_id])
    |> foreign_key_constraint(:course_id)
    |> unique_constraint(:name, name: :university_groups_course_id_name_index)
  end
end
