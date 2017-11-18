defmodule NovelWeb.SubmissionHelpers do
  use Phoenix.HTML

  import NovelWeb.Gettext

  alias Novel.Remote

  def submission_status_options do
    [nil, true, false]
    |> Enum.map(&({submission_status_format(&1), &1}))
  end

  def submission_status_format(is_approved) do
    case is_approved do
      true -> gettext("Yes")
      false -> gettext("No")
      _ -> "-"
    end
  end

  def repository_link(repository) do
    link repository, to: Remote.repository_link(repository)
  end
end
