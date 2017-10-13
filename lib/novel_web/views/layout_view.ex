defmodule NovelWeb.LayoutView do
  use NovelWeb, :view
  import NovelWeb.StringHelper

  def full_name(user) do
    [user.first_name, user.last_name]
    |> Enum.reject(&(blank?(&1)))
    |> Enum.join(" ")
    |> coalesce(user.nickname)
  end
end
