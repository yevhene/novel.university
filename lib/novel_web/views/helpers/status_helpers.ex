defmodule NovelWeb.StatusHelpers do
  use Phoenix.HTML

  def status_icon(status) do
    case status do
      "passed" -> content_tag(:i, "", class: "fa fa-check text-success")
      "intent" -> content_tag(:i, "", class: "fa fa-spinner text-warning")
      "failed" -> content_tag(:i, "", class: "fa fa-times text-danger")
      _ -> ""
    end
  end
end
