defmodule Novel.University.Enrollment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Account.User
  alias Novel.Assignment
  alias Novel.Assignment.Submission
  alias Novel.Exam
  alias Novel.Exam.Attempt
  alias Novel.University.Course
  alias Novel.University.Enrollment
  alias Novel.University.Group

  schema "university_enrollments" do
    belongs_to :course, Course
    belongs_to :group, Group
    belongs_to :user, User

    has_many :submissions, Submission
    has_many :attempts, Attempt

    has_many :assignment_results, Assignment.Result
    has_many :exam_results, Exam.Result

    timestamps(type: :utc_datetime)
  end

  def changeset(%Enrollment{} = enrollment, attrs) do
    enrollment
    |> cast(attrs, [:course_id, :user_id])
    |> validate_required([:course_id, :user_id])
    |> foreign_key_constraint(:course_id)
    |> foreign_key_constraint(:user_id)
    |> foreign_key_constraint(:group_id)
    |> unique_constraint(:course_id,
      name: :university_enrollments_course_id_user_id_index
    )
  end

  def update_changeset(%Enrollment{} = enrollment, attrs) do
    enrollment
    |> cast(attrs, [:group_id])
    |> foreign_key_constraint(:group_id)
  end
end
