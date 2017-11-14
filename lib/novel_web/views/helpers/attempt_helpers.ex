defmodule NovelWeb.AttemptHelpers do
  import NovelWeb.Gettext
  import NovelWeb.StatusHelpers

  alias Novel.Exam

  def format_attempt_status(nil) do
    nil
  end

  def format_attempt_status(attempt) do
    if Exam.is_active?(attempt) do
      gettext "In progress"
    else
      score = attempt.score
      if score do
        [
          :erlang.float_to_binary(score.value * 100, [decimals: 1]) <> "%",
          status_icon(Exam.is_successful?(attempt))
        ]
      else
        "-"
      end
    end
  end
end
