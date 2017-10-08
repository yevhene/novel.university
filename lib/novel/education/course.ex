defmodule Novel.Education.Course do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Education.Course

  schema "courses" do
    field :name, :string
    field :started_at, :date

    timestamps(type: :utc_datetime)
  end

  def changeset(%Course{} = course, attrs) do
    course
    |> cast(attrs, [:name, :started_at])
    |> validate_required([:name, :started_at])
  end
end
