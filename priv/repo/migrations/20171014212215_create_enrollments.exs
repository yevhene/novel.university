defmodule Novel.Repo.Migrations.CreateEnrollments do
  use Ecto.Migration

  def change do
    create table(:university_enrollments) do
      add :group_id, references(:university_groups, on_delete: :restrict)
      add :user_id, references(:account_users, on_delete: :restrict)

      timestamps(type: :utc_datetime)
    end

    create index(:university_enrollments, [:group_id])
    create unique_index(:university_enrollments, [:user_id, :group_id])
  end
end
