defmodule Novel.Repo.Migrations.CreateRemoteRepositories do
  use Ecto.Migration

  def change do
    create table(:remote_repositories) do
      add :name, :string, null: false
      add :owner, :string, null: false
      add :url, :string, null: false
      add :description, :text

      add :provider, :string, null: false

      timestamps(type: :utc_datetime)
    end
  end
end
