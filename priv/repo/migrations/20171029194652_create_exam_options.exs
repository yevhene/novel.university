defmodule Novel.Repo.Migrations.CreateExamOptions do
  use Ecto.Migration

  def change do
    create table(:exam_options) do
      add :text, :text, null: false
      add :is_correct, :boolean, default: false, null: false

      add :question_id,
        references(:exam_questions, on_delete: :delete_all), null: false

      timestamps(type: :utc_datetime)
    end

    create index(:exam_options, [:question_id])
  end
end
