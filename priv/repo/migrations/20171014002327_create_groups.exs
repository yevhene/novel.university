defmodule Novel.Repo.Migrations.CreateGroups do
  use Ecto.Migration

  def change do
    create table(:university_groups) do
      add :name, :string, null: false
      add :invitation_code, :string

      add :course_id, references(:university_courses, on_delete: :restrict),
        null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:university_groups, [:course_id, :name])
    create unique_index(:university_groups, [:invitation_code],
      where: "invitation_code IS NOT NULL"
    )
  end
end
