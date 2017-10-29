defmodule NovelWeb.RepositoryHelper do
  use Phoenix.HTML

  def repository_link(repository) do
    link repository, to: "https://github.com/#{repository}"
  end
end
