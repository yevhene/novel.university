defmodule Novel.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:groups) do
      add :name, :string
      add :course_id, references(:courses, on_delete: :delete_all)

      timestamps(type: :utc_datetime)
    end

    create unique_index(:groups, [:course_id, :name])
  end
end
