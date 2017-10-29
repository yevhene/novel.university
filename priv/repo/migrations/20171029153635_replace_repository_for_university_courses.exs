defmodule Novel.Repo.Migrations.ReplaceRepositoryForUniversityCourses do
  use Ecto.Migration

  def change do
    alter table(:university_courses) do
      remove :repository
      add :repository_id,
        references(:remote_repositories, on_delete: :delete_all)
    end

    create index(:university_courses, [:repository_id])
  end
end
