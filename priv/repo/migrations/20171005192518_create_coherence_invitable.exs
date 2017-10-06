defmodule Novel.Repo.Migrations.CreateCoherenceInvitable do
  use Ecto.Migration
  def change do
    create table(:invitations) do
      add :name, :string
      add :email, :string
      add :token, :string

      timestamps(type: :utc_datetime)
    end

    create unique_index(:invitations, [:email])
    create index(:invitations, [:token])
  end
end
