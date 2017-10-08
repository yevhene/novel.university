defmodule Novel.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :uid, :integer, null: false

      add :email, :string
      add :nickname, :string
      add :is_teacher, :boolean, default: false, null: false

      add :first_name, :string
      add :last_name, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:users, [:uid])
  end
end
