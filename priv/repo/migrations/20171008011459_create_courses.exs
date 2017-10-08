defmodule Novel.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :name, :string, null: false
      add :started_at, :date

      timestamps(type: :utc_datetime)
    end
  end
end
