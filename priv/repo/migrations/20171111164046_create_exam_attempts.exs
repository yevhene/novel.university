defmodule Novel.Repo.Migrations.CreateExamAttempts do
  use Ecto.Migration

  def change do
    create table(:exam_attempts) do
      add :enrollment_id,
        references(:university_enrollments, on_delete: :restrict)
      add :quiz_id, references(:exam_quizzes, on_delete: :restrict)

      timestamps(type: :utc_datetime)
    end

    create index(:exam_attempts, [:enrollment_id])
    create index(:exam_attempts, [:quiz_id])
  end
end
