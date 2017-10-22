defmodule Novel.Repo.Migrations.CreateAssignmentLabs do
  use Ecto.Migration

  def change do
    create table(:assignment_labs) do
      add :title, :string

      add :course_id, references(:university_courses, on_delete: :restrict)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:assignment_labs, [:course_id, :title])
  end
end
