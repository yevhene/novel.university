defmodule Novel.Repo.Migrations.AddRepositoryToUniversityCourses do
  use Ecto.Migration

  def change do
    alter table(:university_courses) do
      add :repository, :string
    end
  end
end
