defmodule NovelWeb.Teacher.EnrollmentView do
  use NovelWeb, :view

  import NovelWeb.UserHelpers
  import NovelWeb.FormatHelpers

  def enrollment_group_options(groups) do
    groups
    |> Enum.map(&{&1.name, &1.id})
    |> Enum.concat([{"-", nil}])
    |> Enum.reverse
  end

  def format_assignment_results(assignment_results) do
    format_results Enum.map(assignment_results, fn result ->
      cond do
        result.is_passed -> "passed"
        result.is_passed == false -> "not_passed"
        result.is_submitted -> "submitted"
        true -> nil
      end
    end)
  end

  def format_exam_results(exam_results) do
    format_results Enum.map(exam_results, fn result ->
      cond do
        result.is_passed -> "passed"
        result.is_passed == false -> "not_passed"
        true -> nil
      end
    end)
  end
end
