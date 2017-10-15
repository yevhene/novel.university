defmodule Novel.Repo.Migrations.CreateCourses do
  use Ecto.Migration

  def change do
    create table(:university_courses) do
      add :name, :string, null: false
      add :description, :text
      add :started_at, :date

      add :head_id, references(:account_users, on_delete: :restrict),
        null: false

      timestamps(type: :utc_datetime)
    end

    create index(:university_courses, [:head_id])
  end
end
