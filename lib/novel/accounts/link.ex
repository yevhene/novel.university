defmodule Novel.Accounts.Link do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Accounts.Link
  alias Novel.Accounts.User

  schema "links" do
    field :data, :map

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  def changeset(%Link{} = link, attrs) do
    link
    |> cast(attrs, [:user_id, :data])
    |> validate_required([:user_id, :data])
    |> foreign_key_constraint(:user_id)
  end
end
