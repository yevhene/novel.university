defmodule NovelWeb.AuthController do
  use NovelWeb, :controller

  import NovelWeb.Guardian.Plug, only: [sign_in: 2]

  alias Novel.Account

  def callback(%{assigns: %{ueberauth_failure: _fails}} = conn, _params) do
    conn
    |> put_flash(:error, gettext "Failed to authenticate")
    |> redirect(to: "/")
  end

  def callback(%{assigns: %{ueberauth_auth: oauth}} = conn, _params) do
    case Account.authenticate(oauth) do
      {:ok, user} ->
        conn
        |> put_flash(:info, gettext "Successfully authenticated")
        |> sign_in(user)
        |> redirect(to: "/")
      {:error, reason} ->
        conn
        |> put_flash(
          :error,
          gettext("Could not authenticate. Error: %{reason}", reason: reason)
        )
        |> redirect(to: "/")
    end
  end
end
