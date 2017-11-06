defmodule NovelWeb.Teacher.QuizView do
  import NovelWeb.Gettext
  use NovelWeb, :view

  import NovelWeb.MarkdownHelper

  def format_sample_size(sample_size, all_size) do
    if sample_size && sample_size > 0 do
      "#{sample_size}/#{all_size}"
    else
      gettext "all/%{all_size}", all_size: Integer.to_string(all_size)
    end
  end

  def format_duration(duration) do
    if duration do
      gettext "%{duration} minute(s)", duration: Integer.to_string(duration)
    else
      gettext "unlimited"
    end
  end
end
