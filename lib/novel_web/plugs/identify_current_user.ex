defmodule NovelWeb.Plug.IdentifyCurrentUser do
  import NovelWeb.Gettext
  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [halt: 1]
  alias NovelWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  def call(conn, _opts) do
    current_user = conn.assigns.current_user
    if user_should_fill_profile?(current_user) do
      conn
      |> put_flash(:info, gettext "Please fill your profile")
      |> redirect(to: Routes.profile_path(conn, :edit))
      |> halt()
    else
      conn
    end
  end

  defp user_should_fill_profile?(user) do
    user && (!user.first_name || !user.last_name)
  end
end
