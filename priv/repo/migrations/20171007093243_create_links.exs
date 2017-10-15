defmodule Novel.Repo.Migrations.CreateLinks do
  use Ecto.Migration

  def change do
    create table(:account_links) do
      add :data, :map

      add :user_id, references(:account_users, on_delete: :delete_all),
        null: false

      timestamps(type: :utc_datetime)
    end

    create index(:account_links, [:user_id])
  end
end
