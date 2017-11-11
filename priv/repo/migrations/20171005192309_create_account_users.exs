defmodule Novel.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:account_users) do
      add :uid, :integer, null: false

      add :email, :string
      add :nickname, :string

      add :first_name, :string
      add :last_name, :string

      add :is_teacher, :boolean, default: false, null: false

      timestamps(type: :utc_datetime)
    end

    create unique_index(:account_users, [:uid])
  end
end
