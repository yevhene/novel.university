defmodule Novel.Account.Link do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Account.User

  alias Novel.Account.Link

  schema "account_links" do
    field :data, :map

    belongs_to :user, User

    timestamps(type: :utc_datetime)
  end

  def changeset(%Link{} = link, attrs) do
    link
    |> cast(attrs, [:data, :user_id])
    |> validate_required([:data, :user_id])
    |> foreign_key_constraint(:user_id)
  end
end
