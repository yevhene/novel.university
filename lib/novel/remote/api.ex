defmodule Novel.Remote.Api do
  import Ecto.Query, warn: false
  alias Novel.Repo

  alias Novel.Account.Link
  alias Novel.Account.User
  alias Tentacat.Client
  alias Tentacat.Repositories

  def list_remotes(%User{} = user, opts \\ []) do
    %Link{
      data: %{
        "provider" => provider,
        "credentials" => %{
          "token" => token
        }
      }
    } = user_link(user)

    fetch_list(provider, token, opts)
  end

  defp fetch_list("github", token, opts \\ []) do
    token
    |> load_github_repositories(opts)
    |> Enum.map(&format_github_repository_data/1)
  end

  defp load_github_repositories(token, opts \\ []) do
    params = Keyword.merge([
      visibility: :public,
      affiliation: :owner,
      sort: :pushed,
      direction: :desc
    ], opts)

    %{access_token: token}
    |> Client.new()
    |> Repositories.list_mine(params)
  end

  defp format_github_repository_data(repository) do
    %{
      provider: "github",
      name: repository["name"],
      owner: repository["owner"]["login"],
      url: repository["html_url"],
      description: repository["description"]
    }
  end

  defp user_link(%User{id: user_id}) do
    Link
    |> where(user_id: ^user_id)
    |> order_by(desc: :inserted_at)
    |> first()
    |> Repo.one()
  end
end
