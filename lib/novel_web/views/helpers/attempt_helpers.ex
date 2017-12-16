defmodule NovelWeb.AttemptHelpers do
  import NovelWeb.Gettext
  import NovelWeb.StatusHelpers

  alias Novel.Exam
  alias NovelWeb.SharedView

  def format_attempt_status(nil) do
    nil
  end

  def format_attempt_status(attempt) do
    if Exam.is_active?(attempt) do
      [
        attempt_timer(attempt),
        gettext "In progress"
      ]
    else
      score = attempt.score
      if score do
        [
          status_icon(attempt.score.is_passed),
          " ",
          :erlang.float_to_binary(score.value * 100, [decimals: 1]) <> "%"
        ]
      else
        "-"
      end
    end
  end

  defp attempt_timer(attempt) do
    SharedView.render(
      "_timer.html",
      finished_at: Exam.finished_at(attempt)
    )
  end
end
