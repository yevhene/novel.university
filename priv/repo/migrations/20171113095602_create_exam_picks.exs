defmodule Novel.Repo.Migrations.CreateExamPicks do
  use Ecto.Migration

  def change do
    create table(:exam_picks) do
      add :is_picked, :boolean, default: false, null: false

      add :answer_id, references(:exam_answers, on_delete: :delete_all)
      add :option_id, references(:exam_options, on_delete: :restrict)

      timestamps(type: :utc_datetime)
    end

    create index(:exam_picks, [:answer_id])
    create unique_index(:exam_picks, [:option_id, :answer_id])
  end
end
