defmodule NovelWeb.ProfileController do
  use NovelWeb, :controller

  alias Novel.Accounts

  def show(conn, _params) do
    user = current_user(conn)
    render(conn, "show.html", user: user)
  end

  def edit(conn, _params) do
    user = current_user(conn)
    changeset = Accounts.change_user_profile(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"user" => user_params}) do
    user = current_user(conn)

    case Accounts.update_user_profile(user, user_params) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: profile_path(conn, :show))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end
end
