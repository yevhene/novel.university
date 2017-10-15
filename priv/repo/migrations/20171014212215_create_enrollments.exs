defmodule Novel.Repo.Migrations.CreateEnrollments do
  use Ecto.Migration

  def change do
    create table(:university_enrollments) do
      add :is_approved, :boolean

      add :course_id, references(:university_courses, on_delete: :restrict)
      add :user_id, references(:account_users, on_delete: :restrict)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:university_enrollments, [:course_id, :user_id])
    create index(:university_enrollments, [:user_id])
  end
end
