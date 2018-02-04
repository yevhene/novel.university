defmodule Novel.Repo.Migrations.AddFinishedAtToUniversityCourses do
  use Ecto.Migration

  def change do
    alter table(:university_courses) do
      add :finished_at, :date
    end
  end
end
