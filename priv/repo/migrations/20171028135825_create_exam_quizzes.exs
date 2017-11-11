defmodule Novel.Repo.Migrations.CreateExamQuizs do
  use Ecto.Migration

  def change do
    create table(:exam_quizzes) do
      add :name, :string, null: false
      add :description, :text

      add :sample_size, :integer
      add :duration, :integer

      add :started_at, :utc_datetime

      add :course_id,
        references(:university_courses, on_delete: :restrict), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:exam_quizzes, [:course_id, :name])
  end
end
