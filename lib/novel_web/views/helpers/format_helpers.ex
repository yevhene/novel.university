defmodule NovelWeb.FormatHelpers do
  use Phoenix.HTML

  import NovelWeb.Gettext
  import Calendar.Strftime

  def format_duration(duration) do
    if duration do
      gettext "%{duration} minute(s)", duration: Integer.to_string(duration)
    else
      "-"
    end
  end

  def format_datetime(nil) do
    nil
  end

  def format_datetime(%DateTime{} = datetime) do
    datetime
    |> strftime!("%d/%m/%Y %H:%M")
  end

  def format_results_string(results) do
    results
    |> Enum.map(fn result ->
      case result.status do
        "passed" -> "+"
        "failed" -> "-"
        "intent" -> "."
        _        -> "_"
      end
    end)
    |> Enum.join
  end

  def format_results(results) do
    content_tag(:ul, class: "results") do
      results |> Enum.map(&format_result/1)
    end
  end

  defp format_result(result) do
    content_tag(:li, "", class: result.status)
  end
end
