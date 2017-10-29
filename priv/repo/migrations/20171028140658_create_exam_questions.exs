defmodule Novel.Repo.Migrations.CreateExamQuestions do
  use Ecto.Migration

  def change do
    create table(:exam_questions) do
      add :title, :text, null: false
      add :details, :text

      add :quiz_id,
        references(:exam_quizzes, on_delete: :restrict), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:exam_questions, [:quiz_id])
  end
end
