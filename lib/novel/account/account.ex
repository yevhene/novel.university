defmodule Novel.Account do
  import Ecto.Query, warn: false
  alias Novel.Repo

  alias Novel.Account.Link
  alias Novel.Account.User

  def get_user!(id), do: Repo.get!(User, id)

  def change_user_profile(%User{} = user) do
    user
    |> User.profile_changeset(%{})
  end

  def update_user_profile(%User{} = user, attrs) do
    user
    |> User.profile_changeset(attrs)
    |> Repo.update()
  end

  def authenticate(%Ueberauth.Auth{} = auth) do
    data = auth |> Map.from_struct

    with {:ok, user} <- user_from_auth(auth),
         {:ok, user} <- refresh_user_info(user, auth),
         {:ok, _link} <- create_link(%{user_id: user.id, data: data})
    do
      {:ok, user}
    else
      _ -> {:error, "Can't authenticate"}
    end
  end

  defp create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  defp create_link(attrs) do
    %Link{}
    |> Link.changeset(attrs)
    |> Repo.insert()
  end

  defp user_from_auth(%{uid: uid}) do
    case User |> Repo.get_by(uid: uid) do
      %User{} = u -> {:ok, u}
      _ -> create_user(%{uid: uid})
    end
  end

  defp refresh_user_info(user, %{info: %{email: email, nickname: nickname}}) do
    changeset = if user.email do
      %{nickname: nickname}
    else
      %{email: email, nickname: nickname}
    end

    user
    |> User.info_changeset(changeset)
    |> Repo.update()
  end
end
