defmodule Novel.Repo.Migrations.CreateUniversityLabs do
  use Ecto.Migration

  def change do
    create table(:university_labs) do
      add :title, :string

      add :course_id, references(:university_courses, on_delete: :restrict)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:university_labs, [:course_id, :title])
  end
end
