defmodule Novel.Repo.Migrations.CreateExamQuestions do
  use Ecto.Migration

  def change do
    create table(:exam_questions) do
      add :text, :text, null: false

      add :tags, {:array, :string}, null: false, default: []
      add :options, {:array, :text}, null: false
      add :correct_keys, {:array, :integer}, null: false

      add :is_deprecated, :boolean, null: false, default: false

      add :quiz_id, references(:exam_quizzes, on_delete: :restrict), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:exam_questions, [:quiz_id])
  end
end
