defmodule Novel.Education.Course do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Accounts.User

  alias Novel.Education.Course

  schema "courses" do
    field :name, :string
    field :description, :string
    field :started_at, :date

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  def changeset(%Course{} = course, attrs) do
    course
    |> cast(attrs, [:name, :description, :started_at, :user_id])
    |> validate_required([:name, :started_at, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
