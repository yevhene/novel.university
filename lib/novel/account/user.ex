defmodule Novel.Account.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Account.Link

  alias Novel.Account.User

  schema "account_users" do
    field :uid, :integer

    field :email, :string
    field :nickname, :string
    field :is_teacher, :boolean

    field :first_name, :string
    field :last_name, :string

    has_many :links, Link

    timestamps(type: :utc_datetime)
  end

  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:uid])
    |> validate_required([:uid])
    |> unique_constraint(:uid)
  end

  def info_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :nickname])
    |> validate_required([:email, :nickname])
  end

  def profile_changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:email, :first_name, :last_name])
    |> validate_required([:email, :first_name, :last_name])
  end
end
