defmodule NovelWeb.StatusHelpers do
  use Phoenix.HTML

  def status_icon(status) do
    case status do
      true -> content_tag(:i, "", class: "fa fa-check text-success")
      false -> content_tag(:i, "", class: "fa fa-times text-danger")
      _ -> ""
    end
  end
end
