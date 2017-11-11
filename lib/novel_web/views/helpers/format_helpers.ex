defmodule NovelWeb.FormatHelpers do
  import NovelWeb.Gettext

  def format_duration(duration) do
    if duration do
      gettext "%{duration} minute(s)", duration: Integer.to_string(duration)
    else
      gettext "unlimited"
    end
  end
end
