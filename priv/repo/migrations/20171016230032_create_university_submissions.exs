defmodule Novel.Repo.Migrations.CreateUniversitySubmissions do
  use Ecto.Migration

  def change do
    create table(:university_submissions) do
      add :repo, :string

      add :enrollment_id,
        references(:university_enrollments, on_delete: :restrict)
      add :lab_id, references(:university_labs, on_delete: :restrict)

      timestamps(type: :utc_datetime)
    end

    create index(:university_submissions, [:enrollment_id])
    create index(:university_submissions, [:lab_id])
  end
end
