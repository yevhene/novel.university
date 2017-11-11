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
end
