defmodule NovelWeb.FormatHelpers do
  import NovelWeb.Gettext
  import Calendar.Strftime

  def format_duration(duration) do
    if duration do
      gettext "%{duration} minute(s)", duration: Integer.to_string(duration)
    else
      gettext "unlimited"
    end
  end

  def format_datetime(nil) do
    nil
  end

  def format_datetime(%DateTime{} = datetime) do
    datetime
    |> strftime!("%d/%m/%Y %H:%M")
  end
end
