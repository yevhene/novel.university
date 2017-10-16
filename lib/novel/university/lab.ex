defmodule Novel.University.Lab do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.University.Course
  alias Novel.University.Lab

  schema "university_labs" do
    field :title, :string

    belongs_to :course, Course

    timestamps(type: :utc_datetime)
  end

  def changeset(%Lab{} = lab, attrs) do
    lab
    |> cast(attrs, [:title, :course_id])
    |> validate_required([:title, :course_id])
    |> foreign_key_constraint(:course_id)
    |> unique_constraint(:title, name: :university_labs_course_id_title_index)
  end
end
