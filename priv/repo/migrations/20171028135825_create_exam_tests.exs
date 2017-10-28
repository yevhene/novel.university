defmodule Novel.Repo.Migrations.CreateExamTests do
  use Ecto.Migration

  def change do
    create table(:exam_tests) do
      add :name, :string, null: false
      add :description, :text

      add :sample_size, :integer

      add :course_id,
        references(:university_courses, on_delete: :restrict), null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:exam_tests, [:course_id, :name])
  end
end
