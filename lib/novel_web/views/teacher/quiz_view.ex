defmodule NovelWeb.Teacher.QuizView do
  import NovelWeb.Gettext
  use NovelWeb, :view

  import NovelWeb.MarkdownHelpers
  import NovelWeb.FormatHelpers

  def format_sample_size(sample_size, all_size) do
    if sample_size && sample_size > 0 do
      "#{sample_size}/#{all_size}"
    else
      gettext "all/%{all_size}", all_size: Integer.to_string(all_size)
    end
  end
end
