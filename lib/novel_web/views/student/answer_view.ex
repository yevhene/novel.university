defmodule NovelWeb.Student.AnswerView do
  use NovelWeb, :view

  import NovelWeb.MarkdownHelpers

  def navigation_item_class(index, current_index) do
    if index == current_index do
      "page-item active"
    else
      "page-item"
    end
  end

  def format_timer(seconds) do
    min = seconds |> div(60) |> format_timer_component()
    sec = seconds |> rem(60) |> format_timer_component()

    "#{min}:#{sec}"
  end

  defp format_timer_component(component) do
    component
    |> Integer.to_string()
    |> String.pad_leading(2, "0")
  end
end
