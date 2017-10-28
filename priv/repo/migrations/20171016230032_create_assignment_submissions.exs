defmodule Novel.Repo.Migrations.CreateAssignmentSubmissions do
  use Ecto.Migration

  def change do
    create table(:assignment_submissions) do
      add :repository, :string, null: false
      add :is_approved, :boolean

      add :enrollment_id,
        references(:university_enrollments, on_delete: :restrict), null: false
      add :lab_id,
        references(:assignment_labs, on_delete: :restrict), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:assignment_submissions, [:enrollment_id])
    create index(:assignment_submissions, [:lab_id])
  end
end
