defmodule Novel.University.Course do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Account.User
  alias Novel.Assignment.Lab
  alias Novel.University.Course
  alias Novel.University.Enrollment
  alias Novel.University.Group

  schema "university_courses" do
    field :name, :string
    field :description, :string
    field :started_at, :date
    field :repository, :string

    belongs_to :head, User

    has_many :groups, Group
    has_many :enrollments, Enrollment
    has_many :labs, Lab

    timestamps(type: :utc_datetime)
  end

  def changeset(%Course{} = course, attrs) do
    course
    |> cast(attrs, [:name, :description, :started_at, :head_id])
    |> validate_required([:name, :started_at, :head_id])
    |> foreign_key_constraint(:head_id)
  end

  def repository_changeset(%Course{} = course, attrs) do
    course
    |> cast(attrs, [:repository])
  end
end
