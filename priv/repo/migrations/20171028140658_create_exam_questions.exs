defmodule Novel.Repo.Migrations.CreateExamQuestions do
  use Ecto.Migration

  def change do
    create table(:exam_questions) do
      add :code, :string, null: false
      add :text, :text, null: false

      add :tags, {:array, :string}, null: false, default: []
      add :options, {:array, :text}, null: false
      add :correct_keys, {:array, :integer}, null: false

      add :is_deprecated, :boolean, null: false, default: false

      add :test_id, references(:exam_tests, on_delete: :restrict), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:exam_questions, [:test_id, :code])
  end
end
