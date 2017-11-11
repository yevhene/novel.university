defmodule NovelWeb.AttemptHelpers do
  import NovelWeb.Gettext

  alias Novel.Exam

  def format_attempt_status(nil) do
    nil
  end

  def format_attempt_status(attempt) do
    if Exam.is_attempt_active?(attempt) do
      gettext "In progress"
    else
      if attempt.score do
        :erlang.float_to_binary(attempt.score * 100, [decimals: 1]) ++ "%"
      else
        gettext "Evaluating"
      end
    end
  end
end
