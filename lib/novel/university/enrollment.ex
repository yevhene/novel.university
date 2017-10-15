defmodule Novel.University.Enrollment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Account.User
  alias Novel.University.Course
  alias Novel.University.Enrollment

  schema "university_enrollments" do
    field :is_approved, :boolean

    belongs_to :course, Course
    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  def changeset(%Enrollment{} = enrollment, attrs) do
    enrollment
    |> cast(attrs, [:course_id, :user_id])
    |> validate_required([:course_id, :user_id])
    |> foreign_key_constraint(:course_id)
    |> foreign_key_constraint(:user_id)
    |> unique_constraint(:course_id,
      name: :university_enrollments_course_id_user_id_index
    )
  end
end
