defmodule NovelWeb.FormatHelper do
  def truncate(text, opts \\ []) do
    truncate_at = opts[:truncate_at] || 255
    separator   = opts[:separator] || " "
    omission    = opts[:omission] || "..."

    cond do
      not String.valid?(text) ->
        text
      String.length(text) < truncate_at ->
        text
      true ->
        total_length = truncate_at - String.length(omission)

        [String.slice(text, 0, total_length), omission]
        |> Enum.join(separator)
    end
  end
end
