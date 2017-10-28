defmodule NovelWeb.RepositoryHelper do
  use Phoenix.HTML

  alias Novel.Remote

  def repository_link(repository) do
    link repository, to: Remote.repository_link(repository)
  end
end
