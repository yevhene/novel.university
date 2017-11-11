defmodule Novel.Repo.Migrations.CreateExamAnswers do
  use Ecto.Migration

  def change do
    create table(:exam_answers) do
      add :attempt_id, references(:exam_attempts, on_delete: :delete_all)
      add :question_id, references(:exam_questions, on_delete: :restrict)

      timestamps(type: :utc_datetime)
    end

    create index(:exam_answers, [:attempt_id])
    create unique_index(:exam_answers, [:question_id, :attempt_id])
  end
end
