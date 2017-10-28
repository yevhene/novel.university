defmodule Novel.Remote do
  import Ecto.Query, warn: false
  alias Novel.Repo

  alias Novel.Account.Link
  alias Novel.Account.User
  alias Tentacat.Client
  alias Tentacat.Repositories

  def list_repositories(%User{} = user, params \\ %{}) do
    %Link{
      data: %{
        "provider" => provider,
        "credentials" => %{
          "token" => token
        }
      }
    } = last_user_link(user)

    fetch_list(provider, token, params)
  end

  def repository_link(name) do
    "https://github.com/#{name}"
  end

  defp fetch_list("github", token, params) do
    token
    |> load_github_repositories(params)
    |> Enum.map(&cleanup_github_repository_data/1)
  end

  defp load_github_repositories(token, params) do
    params = Map.merge(%{
      "visibility" => "public",
      "affiliation" => "owner",
      "sort" => "pushed",
      "direction" => "desc"
    }, params)

    %{access_token: token}
    |> Client.new()
    |> Repositories.list_mine(params)
  end

  defp cleanup_github_repository_data(repository) do
    %{
      name: repository["name"],
      full_name: repository["full_name"],
      url: repository["html_url"],
      description: repository["description"],
      pushed_at: repository["pushed_at"]
    }
  end

  defp last_user_link(%User{id: user_id}) do
    Link
    |> where(user_id: ^user_id)
    |> order_by(desc: :inserted_at)
    |> first()
    |> Repo.one()
  end
end
