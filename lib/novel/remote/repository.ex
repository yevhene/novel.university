defmodule Novel.Remote.Repository do
  use Ecto.Schema
  import Ecto.Changeset

  alias Novel.Remote.Repository

  schema "remote_repositories" do
    field :name, :string
    field :owner, :string
    field :url, :string
    field :provider, :string, default: "github"
    field :description, :string

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(%Repository{} = repository, attrs) do
    repository
    |> cast(attrs, [:name, :owner, :url, :description])
    |> validate_required([:name, :owner, :url])
  end
end
