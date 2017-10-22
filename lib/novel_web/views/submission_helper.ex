defmodule NovelWeb.SubmissionHelper do
  import NovelWeb.Gettext
  use Phoenix.HTML

  alias Novel.Remote

  def submission_approvement_options do
    [nil, true, false]
    |> Enum.map(&({approved_format(&1), &1}))
  end

  def approved_format(is_approved) do
    case is_approved do
      true -> gettext("Yes")
      false -> gettext("No")
      _ -> "-"
    end
  end

  def approved_class(is_approved) do
    case is_approved do
      true -> "list-group-item-success"
      false -> "list-group-item-danger"
      _ -> ""
    end
  end

  def repository_link(repository) do
    link repository, to: Remote.repository_link(repository)
  end
end
