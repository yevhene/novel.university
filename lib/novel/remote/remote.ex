defmodule Novel.Remote do
  import Ecto.Query, warn: false

  alias Novel.Repo
  alias Novel.Remote.Repository

  def get_repository(id) do
    if id do
      Repository
      |> Repo.get(id)
    else
      nil
    end
  end

  def create_repository(attrs \\ %{}) do
    %Repository{}
    |> Repository.changeset(attrs)
    |> Repo.insert()
  end

  def delete_repository(%Repository{} = repository) do
    Repo.delete(repository)
  end

  def change_repository(%Repository{} = repository) do
    Repository.changeset(repository, %{})
  end
end
